#### [PATCH v2]  kvm:x86 :remove unnecessary recalculate_apic_map
##### From: Peng Hao <peng.hao2@zte.com.cn>

```c
In the previous code, the variable sw_apic_disabled influences
recalculate_apic_map. But in "KVM: x86: simplify kvm_apic_map"
(commit:3b5a5ffa928a3f875b0d5dd284eeb7c322e1688a),
the access to sw_apic_disabled in recalculate_apic_map has been
deleted.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/lapic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

```
