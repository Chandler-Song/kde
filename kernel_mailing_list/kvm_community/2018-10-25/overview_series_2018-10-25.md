#### [PATCH]  kvm/x86 : remove unused struct definition
##### From: Peng Hao <peng.hao2@zte.com.cn>

```c
structure svm_init_data is never used. So remove it.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/svm.c | 5 -----
 1 file changed, 5 deletions(-)

```
