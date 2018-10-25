#### [PATCH]  kvm/x86 : remove unused struct definition
##### From: Peng Hao <peng.hao2@zte.com.cn>

```c
structure svm_init_data is never used. So remove it.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/svm.c | 5 -----
 1 file changed, 5 deletions(-)

```
#### [PATCH v2 1/6] x86/kernel/hyper-v: xmm fast hypercall as guest
##### From: Isaku Yamahata <isaku.yamahata@gmail.com>

```c
hyper-v hypercall supports xmm fast hypercall
where argument is exchanged though regular/xmm registers.
This patch implements them and make use of them.
With this patch, hyperv/hv_apic.c and hyperv/mmu.c will use (xmm) fast
hypercall.

Signed-off-by: Isaku Yamahata <isaku.yamahata@gmail.com>
---
 arch/x86/hyperv/mmu.c               |   4 +-
 arch/x86/hyperv/nested.c            |   2 +-
 arch/x86/include/asm/hyperv-tlfs.h  |   3 +
 arch/x86/include/asm/mshyperv.h     | 176 ++++++++++++++++++++++++++++++++++--
 drivers/hv/hv.c                     |   3 +-
 drivers/pci/controller/pci-hyperv.c |   7 +-
 6 files changed, 179 insertions(+), 16 deletions(-)

```
