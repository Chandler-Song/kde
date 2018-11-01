#### [PATCH 1/2] nVMX x86: Check VMX-preemption timer controls on vmentry of L2 guests
##### From: Krish Sadhukhan <krish.sadhukhan@oracle.com>

```c
According to section "Checks on VMX Controls" in Intel SDM vol 3C, the
following check needs to be enforced on vmentry of L2 guests:

    If the "activate VMX-preemption timer" VM-execution control is 0, the
    the "save VMX-preemption timer value" VM-exit control must also be 0.

Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Mihai Carabas <mihai.carabas@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/kvm/vmx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

```
#### [PATCH v1 1/8] perf/x86: add support to mask counters from host
##### From: Wei Wang <wei.w.wang@intel.com>

```c
Add x86_perf_mask_perf_counters to reserve counters from the host perf
subsystem. The masked counters will not be assigned to any host perf
events. This can be used by the hypervisor to reserve perf counters for
a guest to use.

This function is currently supported on Intel CPUs only, but put in x86
perf core because the counter assignment is implemented here and we need
to re-enable the pmu which is defined in the x86 perf core in the case
that a counter to be masked happens to be used by the host.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/events/core.c            | 37 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 38 insertions(+)

```
#### [PATCH v2] KVM: nVMX: Verify eVMCS revision id match supported eVMCS version on eVMCS VMPTRLD
##### From: Liran Alon <liran.alon@oracle.com>

```c
According to TLFS section 16.11.2 Enlightened VMCS, the first u32
field of eVMCS should specify eVMCS VersionNumber.

This version should be in the range of supported eVMCS versions exposed
to guest via CPUID.0x4000000A.EAX[0:15].
The range which KVM expose to guest in this CPUID field should be the
same as the value returned in vmcs_version by nested_enable_evmcs().

According to the above, eVMCS VMPTRLD should verify that version specified
in given eVMCS is in the supported range. However, current code
mistakenly verfies this field against VMCS12_REVISION.

One can also see that when KVM use eVMCS, it makes sure that
alloc_vmcs_cpu() sets allocated eVMCS revision_id to KVM_EVMCS_VERSION.

Obvious fix should just change eVMCS VMPTRLD to verify first u32 field
of eVMCS is equal to KVM_EVMCS_VERSION.
However, it turns out that Microsoft Hyper-V fails to comply to their
own invented interface: When Hyper-V use eVMCS, it just sets first u32
field of eVMCS to revision_id specified in MSR_IA32_VMX_BASIC (In our
case: VMCS12_REVISION). Instead of used eVMCS version number which is
one of the supported versions specified in CPUID.0x4000000A.EAX[0:15].
To overcome Hyper-V bug, we accept either a supported eVMCS version
or VMCS12_REVISION as valid values for first u32 field of eVMCS.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

```
#### [PATCH v3 1/3] kvm, vmx: move CR2 context switch out of assembly path
##### From: Julian Stecklina <jsteckli@amazon.de>

```c
The VM entry/exit path is a giant inline assembly statement. Simplify it
by doing CR2 context switching in plain C. Move CR2 restore behind IBRS
clearing, so we reduce the amount of code we execute with IBRS on.

Using {read,write}_cr2() means KVM will use pv_mmu_ops instead of open
coding native_{read,write}_cr2(). The CR2 code has been done in
assembly since KVM's genesis[1], which predates the addition of the
paravirt ops[2], i.e. KVM isn't deliberately avoiding the paravirt
ops.

[1] Commit 6aa8b732ca01 ("[PATCH] kvm: userspace interface")
[2] Commit d3561b7fa0fb ("[PATCH] paravirt: header and stubs for paravirtualisation")

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Reviewed-by: Jan H. Schönherr <jschoenh@amazon.de>
Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

```
