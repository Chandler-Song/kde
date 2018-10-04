#### VM boot failure on nodes not having DMA32 zone
##### From: Liang C <liangchen.linux@gmail.com>

```c

Hi,

We have a situation where our qemu processes need to be launched under
cgroup cpuset.mems control. This introduces an similar issue that was
discussed a few years ago. The difference here is that for our case,
not being able to allocate from DMA32 zone is a result a cgroup
restriction not mempolicy enforcement. Here is the steps to reproduce
the failure,

mkdir /sys/fs/cgroup/cpuset/nodeX (where X is a node not having DMA32 zone)
echo X > /sys/fs/cgroup/cpuset/nodeX/cpuset.mems
echo X > /sys/fs/cgroup/cpuset/nodeX/cpuset.cpus
echo 1 > /sys/fs/cgroup/cpuset/node0/cpuset.mem_hardwall
echo $$ > /sys/fs/cgroup/cpuset/nodeX/tasks

#launch a virtual machine
kvm_init_vcpu failed: Cannot allocate memory

There are workarounds, like always putting qemu processes onto the
node with DMA32 zone or not restricting qemu processes memory
allocation until that DMA32 alloc finishes (difficult to be precise).
But we would like to find a way to address the root cause.

Considering the fact that the pae_root shadow should not be needed
when ept is in use, which is indeed our case - ept is always available
for us (guessing this is the same case for most of other users), we
made a patch roughly like this,



It works through our test cases. But we would really like to have your
insight on this patch before applying it in production environment and
contributing it back to the community. Thanks in advance for any help
you may provide!

Thanks,
Liang Chen

```
#### [PATCH] KVM/MMU: Combine flushing remote tlb in mmu_set_spte()
##### From: Tianyu Lan <Tianyu.Lan@microsoft.com>

```c

mmu_set_spte() flushes remote tlbs for drop_parent_pte/drop_spte()
and set_spte() separately. This may introduce redundant flush. This
patch is to combine these flushes and check flush request after
calling set_spte().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
Reviewed-by: Junaid Shahid <junaids@google.com>
Reviewed-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 arch/x86/kvm/mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

```
