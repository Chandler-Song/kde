#### [PATCH v4 RESEND 1/6] KVM: X86: Add kvm hypervisor init time platform
##### From: Wanpeng Li <kernellwp@gmail.com>

```c

From: Wanpeng Li <wanpengli@tencent.com>

Add kvm hypervisor init time platform setup callback which
will be used to replace native apic hooks by pararvirtual
hooks.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

```
#### [PATCH] kvm/x86: propagate fetch fault into guest
##### From: Peng Hao <peng.hao2@zte.com.cn>

```c

When handling ept misconfig exit, it will call emulate instruction
with insn_len = 0. The decode instruction function may return a fetch
fault and should propagate to guest.

The problem will result to emulation fail.
KVM internal error. Suberror: 1
emulation failure
EAX=f81a0024 EBX=f6a07000 ECX=f6a0737c EDX=f8be0118
ESI=f6a0737c EDI=00000021 EBP=f6929f98 ESP=f6929f98
EIP=f8bdd141 EFL=00010086 [--S--P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
SS =0068 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
FS =00d8 2c044000 ffffffff 00809300 DPL=0 DS16 [-WA]
GS =0033 081a44c8 01000fff 00d0f300 DPL=3 DS   [-WA]
LDT=0000 00000000 ffffffff 00000000
TR =0080 f6ea0c80 0000206b 00008b00 DPL=0 TSS32-busy
GDT=     f6e99000 000000ff
IDT=     fffbb000 000007ff
CR0=80050033 CR2=b757d000 CR3=35d31000 CR4=001406d0

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/kvm/emulate.c | 7 +++++--
 arch/x86/kvm/x86.c     | 4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

```
#### [PATCH v5 1/6] KVM: X86: Add kvm hypervisor init time platform setup
##### From: Wanpeng Li <kernellwp@gmail.com>

```c

From: Wanpeng Li <wanpengli@tencent.com>

Add kvm hypervisor init time platform setup callback which
will be used to replace native apic hooks by pararvirtual
hooks.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

```
#### [PATCH] KVM: Compile hv_remote_flush_tlb() and check_ept_pointer()
##### From: Tianyu Lan <Tianyu.Lan@microsoft.com>

```c

This patch is to avoid compilation warning when CONFIG_HYPERV isn't enabled.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx.c | 84 +++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

```
#### [Resend PATCH] KVM/x86: Move X86_CR4_OSXSAVE check into
##### From: Tianyu Lan <Tianyu.Lan@microsoft.com>

```c

X86_CR4_OSXSAVE check belongs to sregs check and so move into
kvm_valid_sregs().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/x86.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

```
#### [PATCH 4.4 031/107] x86/speculation: Update Speculation Control
##### From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

```c

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 1751342095f0d2b36fa8114d8e12c5688c455ac4 upstream.

Intel have retroactively blessed the 0xc2 microcode on Skylake mobile
and desktop parts, and the Gemini Lake 0x22 microcode is apparently fine
too. We blacklisted the latter purely because it was present with all
the other problematic ones in the 2018-01-08 release, but now it's
explicitly listed as OK.

We still list 0x84 for the various Kaby Lake / Coffee Lake parts, as
that appeared in one version of the blacklist and then reverted to
0x80 again. We can change it if 0x84 is actually announced to be safe.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Cc: sironi@amazon.de
Link: http://lkml.kernel.org/r/1518305967-31356-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/kernel/cpu/intel.c |    4 ----
```
#### [PATCH v2 01/17] x86/cpu: create Dhyana init file and register new
##### From: Pu Wen <puwen@hygon.cn>

```c

Add x86 architecture support for new processor Hygon Dhyana Family 18h.
Rework to create a separated file(arch/x86/kernel/cpu/hygon.c) from the
AMD init one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana CPU. In
this way we can remove old AMD architecture support codes from Hygon
code path and generate a clear initialization flow for Hygon processors,
it also reduce long-term maintenance effort.
Also add hygon.c Maintainer information in accordance.

To identify Hygon processors, add a new vendor type X86_VENDOR_HYGON(9)
for system recognition.

To enable Hygon processor config, add a separated Kconfig entry(CPU_SUP_
HYGON) for Dhyana CPU in kernel config setup.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 MAINTAINERS                      |   6 +
 arch/x86/Kconfig.cpu             |  13 ++
 arch/x86/include/asm/processor.h |   3 +-
 arch/x86/kernel/cpu/Makefile     |   1 +
 arch/x86/kernel/cpu/hygon.c      | 401 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 423 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/hygon.c

```
#### [PATCH 01/11] KVM: vmx: move msr_host_bndcfgs out of struct
##### From: Sean Christopherson <sean.j.christopherson@intel.com>

```c

Future patches will change the semantics of 'struct host_state' from
a straightforward tracker to a means of optimizing away unnecessary
VMWRITEs.  Move msr_host_bndcfgs out of host_state as it won't mesh
with the new semantics, to allow for more proper naming of host_state
and to constrain a likely conflict with another in-flight patch[1] to
this non-functional change.

[1] https://www.spinics.net/lists/kvm/msg171645.html

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Peter Shier <pshier@google.com>
Tested-by: Peter Shier <pshier@google.com>
---
 arch/x86/kvm/vmx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

```
#### [RFC PATCH 1/3] kvm/x86: remove KVM_REQ_PENDING_TIMER
##### From: Isaku Yamahata <isaku.yamahata@gmail.com>

```c

From: Isaku Yamahata <isaku.yamahata@intel.com>

Since it doesn't make sense as kvm_cpu_has_pending_timer replaced it,
remove dead code.

Signed-off-by: Isaku Yamahata <isaku.yamahata@gmail.com>
---
 arch/x86/kvm/lapic.c     |  1 -
 arch/x86/kvm/x86.c       | 11 -----------
 include/linux/kvm_host.h |  2 +-
 3 files changed, 1 insertion(+), 13 deletions(-)

```
#### [PATCH 1/2] x86/kvm: typo kvm_emulate.h
##### From: Isaku Yamahata <isaku.yamahata@gmail.com>

```c

From: Isaku Yamahata <isaku.yamahata@intel.com>

ICTP -> ICPT

Signed-off-by: Isaku Yamahata <isaku.yamahata@gmail.com>
---
 arch/x86/include/asm/kvm_emulate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

```
#### [kvm-unit-test] nVMX x86: "external-interrupt exiting" must be set if
##### From: Krish Sadhukhan <krish.sadhukhan@oracle.com>

```c

According to section "Checks on VMX Controls" in Intel SDM vol 3C,
the following check needs to be enforced on vmentry of L2 guests:

    If the "virtual-interrupt delivery" VM-execution control is 1, the
    "external-interrupt exiting" VM-execution control must be 1.

This unit-test validates the above vmentry check.

Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 x86/vmx_tests.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

```
#### [PATCH] kvm: vmx: Move check for MSR bitmap support into
##### From: Peter Shier <pshier@google.com>

```c

vmx_update_msr_bitmap should only run if the CPU supports the "use MSR
bitmaps" VM-execution control. Some callers make the check but one does
not. This change moves the check from the call sites into
vmx_update_msr_bitmap to ensure that the check is always done.

Signed-off-by: Peter Shier <pshier@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

```
