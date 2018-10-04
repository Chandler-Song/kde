#### [kvm-unit-tests PATCH v2] Makefiles: Remove the executable bit from
##### From: Thomas Huth <thuth@redhat.com>

```c

The .elf and .flat files are not runnable on the host operating system,
so they should not be marked as executable.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 v2:
 - Removed "rpm coloring" sentence from the patch description
 - Use "@" in front of the chmods

 arm/Makefile.common     | 2 ++
 powerpc/Makefile.common | 2 ++
 s390x/Makefile          | 1 +
 x86/Makefile.common     | 2 ++
 4 files changed, 7 insertions(+)

```
#### [PATCH RFC] x86/kvm/lapic: always disable MMIO interface in x2APIC
##### From: Vitaly Kuznetsov <vkuznets@redhat.com>

```c

When VMX is used with flexpriority disabled (because of no support or
if disabled with module parameter) MMIO interface to lAPIC is still
available in x2APIC mode while it shouldn't be (kvm-unit-tests):

PASS: apic_disable: Local apic enabled in x2APIC mode
PASS: apic_disable: CPUID.1H:EDX.APIC[bit 9] is set
FAIL: apic_disable: *0xfee00030: 50014

The issue appears because we basically do nothing while switching to
x2APIC mode when APIC access page is not used. apic_mmio_{read,write}
only check if lAPIC is disabled before proceeding to actual write.

When APIC access is virtualized we correctly manipulate with VMX controls
in vmx_set_virtual_apic_mode() and we don't get vmexits from memory writes
in x2APIC mode so there's no issue.

Disabling MMIO interface seems to be easy. The question is: what do we
do with these reads and writes? If we add apic_x2apic_mode() check to
apic_mmio_in_range() and return -EOPNOTSUPP these reads and writes will
go to userspace. When lAPIC is in kernel, Qemu uses this interface to
inject MSIs only (see kvm_apic_mem_write() in hw/i386/kvm/apic.c). This
somehow works with disabled lAPIC but when we're in xAPIC mode we will
get a real injected MSI from every write to lAPIC. Not good.

The simplest solution seems to be to just ignore writes to the region
and return ~0 for all reads when we're in x2APIC mode. This is what this
patch does. However, this approach is inconsistent with what currently
happens when flexpriority is enabled: we allocate APIC access page and
create KVM memory region so in x2APIC modes all reads and writes go to
this pre-allocated page which is, btw, the same for all vCPUs.

The other solution would be to pre-allocate a 'shadow' page for lAPICs
in disabled/x2APIC mode and re-direct all reads and writes there. I'm,
however, not convinced this is a good thing to do.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/lapic.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

```
#### [PATCH] KVM: try __get_user_pages_fast even if not in atomic context
##### From: Paolo Bonzini <pbonzini@redhat.com>

```c

We are currently cutting hva_to_pfn_fast short if we do not want an
immediate exit, which is represented by !async && !atomic.  However,
this is unnecessary, and __get_user_pages_fast is *much* faster
because the regular get_user_pages takes pmd_lock/pte_lock.
In fact, when many CPUs take a nested vmexit at the same time
the contention on those locks is visible, and this patch removes
about 25% (compared to 4.18) from vmexit.flat on a 16 vCPU
nested guest.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
---
 virt/kvm/kvm_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

```
#### [PATCH] kvm: nVMX: Fix fault vector for VMX operation at CPL > 0
##### From: Jim Mattson <jmattson@google.com>

```c

The fault that should be raised for a privilege level violation is #GP
rather than #UD.

Fixes: 727ba748e110b4 ("kvm: nVMX: Enforce cpl=0 for VMX instructions")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/kvm/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

```
#### [PATCH] x86/kvm/mmu: get rid of redundant kvm_mmu_setup()
##### From: Paolo Bonzini <pbonzini@redhat.com>

```c

Just inline the contents into the sole caller, kvm_init_mmu is now
public.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/mmu.c              | 7 -------
 arch/x86/kvm/x86.c              | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

```
#### [PATCH 1/4] x86/kvm/mmu: make vcpu->mmu a pointer to the current MMU
##### From: Paolo Bonzini <pbonzini@redhat.com>

```c

From: Vitaly Kuznetsov <vkuznets@redhat.com>

As a preparation to full MMU split between L1 and L2 make vcpu->arch.mmu
a pointer to the currently used mmu. For now, this is always
vcpu->arch.root_mmu. No functional change.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |   5 +-
 arch/x86/kvm/mmu.c              | 165 ++++++++++++++++++++--------------------
 arch/x86/kvm/mmu.h              |   8 +-
 arch/x86/kvm/mmu_audit.c        |  12 +--
 arch/x86/kvm/paging_tmpl.h      |  15 ++--
 arch/x86/kvm/svm.c              |  14 ++--
 arch/x86/kvm/vmx.c              |  15 ++--
 arch/x86/kvm/x86.c              |  20 ++---
 8 files changed, 130 insertions(+), 124 deletions(-)

```
#### [PATCH] kvm: nVMX: Fix fault priority for VMX operations
##### From: Jim Mattson <jmattson@google.com>

```c

When checking emulated VMX instructions for faults, the #UD for "IF
(not in VMX operation)" should take precedence over the #GP for "ELSIF
CPL > 0."

Suggested-by: Eric Northup <digitaleric@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/kvm/vmx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

```
