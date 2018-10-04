#### [PATCH]  kvm:x86 :remove necessary recalculate_apic_map
##### From: Peng Hao <peng.hao2@zte.com.cn>

```c

In the previous code, the variable sw_apic_disabled influences
recalculate_apic_map. Now it never has accessed sw_apic_disabled
in recalculate_apic_map.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/lapic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

```
#### [PATCH 1/2] vfio: add edid api for display (vgpu) devices.
##### From: Gerd Hoffmann <kraxel@redhat.com>

```c

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/vfio.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

```
#### [PATCH 1/2] KVM: nVMX: Do not expose MPX VMX controls when guest MPX
##### From: Liran Alon <liran.alon@oracle.com>

```c

Before this commit, KVM exposes MPX VMX controls to L1 guest only based
on if KVM and host processor supports MPX virtualization.
However, these controls should be exposed to guest only in case guest
vCPU supports MPX.

Without this change, a L1 guest running with kernel which don't have
commit 691bd4340bef ("kvm: vmx: allow host to access guest
MSR_IA32_BNDCFGS") asserts in QEMU on the following:
	qemu-kvm: error: failed to set MSR 0xd90 to 0x0
	qemu-kvm: .../qemu-2.10.0/target/i386/kvm.c:1801 kvm_put_msrs:
	Assertion 'ret == cpu->kvm_msr_buf->nmsrs failed'
This is because L1 KVM kvm_init_msr_list() will see that
vmx_mpx_supported() (As it only checks MPX VMX controls support) and
therefore KVM_GET_MSR_INDEX_LIST IOCTL will include MSR_IA32_BNDCFGS.
However, later when L1 will attempt to set this MSR via KVM_SET_MSRS
IOCTL, it will fail because !guest_cpuid_has_mpx(vcpu).

Therefore, fix the issue by exposing MPX VMX controls to L1 guest only
when vCPU supports MPX.

Fixes: 36be0b9deb23 ("KVM: x86: Add nested virtualization support for MPX")

Reported-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/kvm/vmx.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

```
#### [PATCH v2] drivers/vfio: Allow type-1 IOMMU instantiation with all
##### From: Geert Uytterhoeven <geert+renesas@glider.be>

```c

Currently the type-1 IOMMU instantiation depends on "ARM_SMMU ||
ARM_SMMU_V3", while it applies to other ARM/ARM64 platforms with an
IOMMU (e.g. Renesas VMSA-compatible IPMMUs).

Instead of extending the list of IOMMU types on ARM platforms, replace
the list by "ARM || ARM64", like other architectures do.  The feature is
still restricted to ARM/ARM64 platforms with an IOMMU by the dependency
on IOMMU_API.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
Tested with sata_rcar on Renesas R-Car H3 ES2.0.

This causes a trivial merge conflict with commit c01eaa95ad30897b ("Make
anon_inodes unconditional") in vfs/for-next.

v2:
  - Make the feature just depend on ARM || ARM64, instead of adding yet
    another IPMMU_VMSA dependency, as suggested by Robin Murphy
    <robin.murphy@arm.com>.
---
 drivers/vfio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

```
#### [PATCH v2 1/2] KVM: nVMX: Do not expose MPX VMX controls when guest
##### From: Liran Alon <liran.alon@oracle.com>

```c

Before this commit, KVM exposes MPX VMX controls to L1 guest only based
on if KVM and host processor supports MPX virtualization.
However, these controls should be exposed to guest only in case guest
vCPU supports MPX.

Without this change, a L1 guest running with kernel which don't have
commit 691bd4340bef ("kvm: vmx: allow host to access guest
MSR_IA32_BNDCFGS") asserts in QEMU on the following:
	qemu-kvm: error: failed to set MSR 0xd90 to 0x0
	qemu-kvm: .../qemu-2.10.0/target/i386/kvm.c:1801 kvm_put_msrs:
	Assertion 'ret == cpu->kvm_msr_buf->nmsrs failed'
This is because L1 KVM kvm_init_msr_list() will see that
vmx_mpx_supported() (As it only checks MPX VMX controls support) and
therefore KVM_GET_MSR_INDEX_LIST IOCTL will include MSR_IA32_BNDCFGS.
However, later when L1 will attempt to set this MSR via KVM_SET_MSRS
IOCTL, it will fail because !guest_cpuid_has_mpx(vcpu).

Therefore, fix the issue by exposing MPX VMX controls to L1 guest only
when vCPU supports MPX.

Fixes: 36be0b9deb23 ("KVM: x86: Add nested virtualization support for MPX")

Reported-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/kvm/vmx.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

```
#### [PATCH v5 01/12] KVM: hyperv: define VP assist page helpers
##### From: Vitaly Kuznetsov <vkuznets@redhat.com>

```c

From: Ladi Prosek <lprosek@redhat.com>

The state related to the VP assist page is still managed by the LAPIC
code in the pv_eoi field.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/kvm/hyperv.c | 23 +++++++++++++++++++++--
 arch/x86/kvm/hyperv.h |  4 ++++
 arch/x86/kvm/lapic.c  |  4 ++--
 arch/x86/kvm/lapic.h  |  2 +-
 arch/x86/kvm/x86.c    |  2 +-
 5 files changed, 29 insertions(+), 6 deletions(-)

```
#### [PATCH] KVM: nVMX: Always reflect #NM VM-exits to L1
##### From: Jim Mattson <jmattson@google.com>

```c

When bit 3 (corresponding to CR0.TS) of the VMCS12 cr0_guest_host_mask
field is clear, the VMCS12 guest_cr0 field does not necessarily hold
the current value of the L2 CR0.TS bit, so the code that checked for
L2's CR0.TS bit being set was incorrect. Moreover, I'm not sure that
the CR0.TS check was adequate. (What if L2's CR0.EM was set, for
instance?)

Fortunately, lazy FPU has gone away, so L0 has lost all interest in
intercepting #NM exceptions. See commit bd7e5b0899a4 ("KVM: x86:
remove code for lazy FPU handling"). Therefore, there is no longer any
question of which hypervisor gets first dibs. The #NM VM-exit should
always be reflected to L1. (Note that the corresponding bit must be
set in the VMCS12 exception_bitmap field for there to be an #NM
VM-exit at all.)

Fixes: ccf9844e5d99c ("kvm, vmx: Really fix lazy FPU on nested guest")
Reported-by: Abhiroop Dabral <adabral@paloaltonetworks.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Tested-by: Abhiroop Dabral <adabral@paloaltonetworks.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/kvm/vmx.c | 8 --------
 1 file changed, 8 deletions(-)

```
#### [PATCH V7 1/2] xxHash: create arch dependent 32/64-bit xxhash()
##### From: Timofey Titovets <timofey.titovets@synesis.ru>

```c

From: Timofey Titovets <nefelim4ag@gmail.com>

xxh32() - fast on both 32/64-bit platforms
xxh64() - fast only on 64-bit platform

Create xxhash() which will pickup fastest version
on compile time.

As result depends on cpu word size,
the main proporse of that - in memory hashing.

Changes:
  v2:
    - Create that patch
  v3 -> v6:
    - Nothing, whole patchset version bump

Signed-off-by: Timofey Titovets <nefelim4ag@gmail.com>
CC: Andrea Arcangeli <aarcange@redhat.com>
CC: linux-mm@kvack.org
CC: kvm@vger.kernel.org
CC: leesioh <solee@os.korea.ac.kr>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 include/linux/xxhash.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

```
#### [PATCH V8 1/2] xxHash: create arch dependent 32/64-bit xxhash()
##### From: Timofey Titovets <timofey.titovets@synesis.ru>

```c

From: Timofey Titovets <nefelim4ag@gmail.com>

xxh32() - fast on both 32/64-bit platforms
xxh64() - fast only on 64-bit platform

Create xxhash() which will pickup fastest version
on compile time.

As result depends on cpu word size,
the main proporse of that - in memory hashing.

Changes:
  v2:
    - Create that patch
  v3 -> v8:
    - Nothing, whole patchset version bump

Signed-off-by: Timofey Titovets <nefelim4ag@gmail.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>

CC: Andrea Arcangeli <aarcange@redhat.com>
CC: linux-mm@kvack.org
CC: kvm@vger.kernel.org
CC: leesioh <solee@os.korea.ac.kr>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 include/linux/xxhash.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

```
#### [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold shared
##### From: Brijesh Singh <brijesh.singh@amd.com>

```c

kvmclock defines few static variables which are shared with the
hypervisor during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if the guest OS wants to share the memory region with the hypervisor
then it must clear the C-bit before sharing it.

Currently, we use kernel_physical_mapping_init() to split large pages
before clearing the C-bit on shared pages. But it fails when called from
the kvmclock initialization (mainly because the memblock allocator is
not ready that early during boot).

Add a __bss_decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed in the
.bss..decrypted section. This section will be mapped with C=0 early
during boot.

The .bss..decrypted section has a big chunk of memory that may be unused
when memory encryption is not active, free it when memory encryption is
not active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
---
 arch/x86/include/asm/mem_encrypt.h |  7 +++++++
 arch/x86/kernel/head64.c           | 16 ++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      | 19 +++++++++++++++++++
 arch/x86/mm/init.c                 |  4 ++++
 arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
 5 files changed, 56 insertions(+)

```
