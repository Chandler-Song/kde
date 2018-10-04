#### [PATCH 1/1] vhost: change the signature of __vhost_get_user_slow()
##### From: Dongli Zhang <dongli.zhang@oracle.com>

```c

Remove 'type' from the signature of __vhost_get_user_slow() as it is not
used.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/vhost/vhost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

```
#### [PATCH] KVM: Remove CREATE_IRQCHIP/SET_PIT2 race
##### From: Peter Shier <pshier@google.com>

```c

From: Steve Rutherford <srutherford@google.com>

Fixes a NULL pointer dereference, caused by the PIT firing an interrupt
before the interrupt table has been initialized.

SET_PIT2 can race with the creation of the IRQchip. In particular,
if SET_PIT2 is called with a low PIT timer period (after the creation of
the IOAPIC, but before the instantiation of the irq routes), the PIT can
fire an interrupt at an uninitialized table.

Signed-off-by: Steve Rutherford <srutherford@google.com>
Signed-off-by: Peter Shier <pshier@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/x86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

```
