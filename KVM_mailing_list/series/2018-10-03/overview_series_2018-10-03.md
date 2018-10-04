#### [PATCH] kvm: nVMX: fix entry with pending interrupt if APICv is
##### From: Paolo Bonzini <pbonzini@redhat.com>

```c

Commit b5861e5cf2fcf83031ea3e26b0a69d887adf7d21 introduced a check on
the interrupt-window and NMI-window CPU execution controls in order to
inject an external interrupt vmexit before the first guest instruction
executes.  However, when APIC virtualization is enabled the host does not
need a vmexit in order to inject an interrupt at the next interrupt window;
instead, it just places the interrupt vector in RVI and the processor will
inject it as soon as possible.  Therefore, on machines with APICv it is
not enough to check the CPU execution controls: the same scenario can also
happen if RVI>0.

Fixes: b5861e5cf2fcf83031ea3e26b0a69d887adf7d21
Cc: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
---
 arch/x86/kvm/vmx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

```
#### [PATCH v2] kvm: nVMX: fix entry with pending interrupt if APICv is
##### From: Paolo Bonzini <pbonzini@redhat.com>

```c

Commit b5861e5cf2fcf83031ea3e26b0a69d887adf7d21 introduced a check on
the interrupt-window and NMI-window CPU execution controls in order to
inject an external interrupt vmexit before the first guest instruction
executes.  However, when APIC virtualization is enabled the host does not
need a vmexit in order to inject an interrupt at the next interrupt window;
instead, it just places the interrupt vector in RVI and the processor will
inject it as soon as possible.  Therefore, on machines with APICv it is
not enough to check the CPU execution controls: the same scenario can also
happen if RVI>0.

Fixes: b5861e5cf2fcf83031ea3e26b0a69d887adf7d21
Cc: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
---
 arch/x86/kvm/vmx.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

```
#### [PATCH] KVM: VMX: check flexpriority module param when setting virt
##### From: Sean Christopherson <sean.j.christopherson@intel.com>

```c

Query the flexpriority module param instead of simply checking if
flexpriority is supported by the cpu when checking whether or not VMCS
fields need to be updated in response to the guest changing its
APIC_BASE MSR control bits.  This avoids multiple unnecessary VMREADs
and a VMWRITE if flexpriority is disabled via its module param and the
cpu doesn't support X2APIC virtualization.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

This is basically fixup for commit 76e97cc35522 ("KVM: VMX: check for
existence of secondary exec controls before accessing") in
kvm.git/queue.  The aforementioned commit came from a series with a
prior patch that removed the module param, but the prior patch was
ultimately rejected resulting in this partially wrong code.

 arch/x86/kvm/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

```
