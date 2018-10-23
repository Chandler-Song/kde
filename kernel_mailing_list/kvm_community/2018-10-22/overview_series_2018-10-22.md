#### [PATCH] KVM/nVMX: Remove uneeded forward jump in nested_vmx_check_vmentry_hw asm
##### From: Uros Bizjak <ubizjak@gmail.com>

```c
There is no need to jump just after the jump insn itself. Also, make
code similar to entering guest mode in vmx_vcpu_run.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kvm/vmx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

```
