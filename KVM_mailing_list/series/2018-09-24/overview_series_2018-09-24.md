#### [PATCH] KVM: x86: never trap MSR_KERNEL_GS_BASE
##### From: Paolo Bonzini <pbonzini@redhat.com>

```c

KVM has an old optimization whereby accesses to the kernel GS base MSR
are trapped when the guest is in 32-bit and not when it is in 64-bit mode.
The idea is that swapgs is not available in 32-bit mode and thus the
guest has no reason to access the MSR unless in 64-bit mode.  Therefore
32-bit applications need not pay the price of switching the kernel GS
base between the host and the guest values, 64-bit applications.

However, this optimization adds complexity to the code for little
benefit (these days most guests are going to be 64-bit anyway) and in fact
broke after commit 678e315e78a7 ("KVM: vmx: add dedicated utility to
access guest's kernel_gs_base", 2018-08-06); the guest kernel GS base
is not restored correctly by the RSM instruction and UEFI Secure Boot
was broken.  This patch just removes the optimization; the kernel
GS base MSR is now never trapped by KVM, similarly to the FS and GS
base MSRs.

Fixes: 678e315e78a780dbef384b92339c8414309dbc11
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 47 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

```
#### [PATCH] KVM: x86: never trap MSR_KERNEL_GS_BASE
##### From: Paolo Bonzini <pbonzini@redhat.com>

```c

KVM has an old optimization whereby accesses to the kernel GS base MSR
are trapped when the guest is in 32-bit and not when it is in 64-bit mode.
The idea is that swapgs is not available in 32-bit mode and thus the
guest has no reason to access the MSR unless in 64-bit mode.  Therefore
32-bit applications need not pay the price of switching the kernel GS
base between the host and the guest values, 64-bit applications.

However, this optimization adds complexity to the code for little
benefit (these days most guests are going to be 64-bit anyway) and in fact
broke after commit 678e315e78a7 ("KVM: vmx: add dedicated utility to
access guest's kernel_gs_base", 2018-08-06); the guest kernel GS base
can be corrupted across SMIs and UEFI Secure Boot is therefore broken
(a secure boot Linux guest, for example, fails to reach the login prompt
about half the time).  This patch just removes the optimization; the
kernel GS base MSR is now never trapped by KVM, similarly to the FS and
GS base MSRs.

Fixes: 678e315e78a780dbef384b92339c8414309dbc11
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx.c | 47 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

```
#### [PATCH v2] KVM: nVMX: Unrestricted guest mode requires EPT
##### From: Jim Mattson <jmattson@google.com>

```c

As specified in Intel's SDM, do not allow the L1 hypervisor to launch
an L2 guest with the VM-execution controls for "unrestricted guest" or
"mode-based execute control for EPT" set and the VM-execution control
for "enable EPT" clear.

Note that the VM-execution control for "mode-based execute control for
EPT" is not yet virtualized by kvm.

Reported-by: Andrew Thornton <andrewth@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/include/asm/vmx.h |  1 +
 arch/x86/kvm/vmx.c         | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

```
