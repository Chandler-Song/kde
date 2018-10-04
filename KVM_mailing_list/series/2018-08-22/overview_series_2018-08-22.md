#### [PATCH V4 1/4] kvm: remove redundant reserved page check
##### From: Zhang Yi <yi.z.zhang@linux.intel.com>

```c

PageReserved() is already checked inside kvm_is_reserved_pfn(),
remove it from kvm_set_pfn_dirty().

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Pankaj Gupta <pagupta@redhat.com>
---
 virt/kvm/kvm_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

```
#### [PATCH v2 1/5] tools: introduce test_and_clear_bit
##### From: Peter Xu <peterx@redhat.com>

```c

We have test_and_set_bit but not test_and_clear_bit.  Add it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/include/linux/bitmap.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

```
#### [PATCH] x86/kvm/vmx: Fix GPF on reading vmentry_l1d_flush
##### From: =?iso-2022-jp?b?TUlOT1VSQSBNYWtvdG8gLyAbJEJMJzE6GyhCIBskQj8/GyhC?=

```c

When EPT is not enabled, reading
/sys/module/kvm_intel/parameters/vmentry_l1d_flush causes
general protection fault in vmentry_l1d_flush_get() due to
access beyond the end of the array vmentry_l1d_param[].

Signed-off-by: Minoura Makoto <minoura@valinux.co.jp>
Tested-by: Jack Wang <jinpu.wang@profitbricks.com>
---
 arch/x86/include/asm/vmx.h | 1 +
 arch/x86/kvm/vmx.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

```
#### [PATCH] KVM: s390: vsie: Consolidate CRYCB validation
##### From: Pierre Morel <pmorel@linux.ibm.com>

```c

Currently when shadowing the CRYCB on SIE entrance, the validation
tests the following:
- accept only FORMAT1 or FORMAT2
- test if MSAext facility (76) is installed
- accept the CRYCB if no keys are used
- verifies that the CRYCB format1 is inside a page
- verifies that the CRYCB origin is not 0

This is not following the architecture.

On SIE entrance, the CRYCB must be validated before accepting
any of its entries.

Let's do the validation in the right order and also verify
correctly the FORMAT2 CRYCB.

The testing of facility MSAext3 (76) is not useful as it is
already tested by kvm_crypto_init() to set FORMAT1.

The testing of a null CRYCB origin must be done what ever
the format of the guest3 CRYCB is.

The CRYCB must be contained inside a page, but the CRYCB size
depends on the CRYCB format.
Lets test what the guest2 initialized, we can not trust it to have
done things right.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

```
#### [PATCH v4 RESEND 1/5] KVM: x86: hyperv: enforce vp_index <
##### From: Vitaly Kuznetsov <vkuznets@redhat.com>

```c

Hyper-V TLFS (5.0b) states:

> Virtual processors are identified by using an index (VP index). The
> maximum number of virtual processors per partition supported by the
> current implementation of the hypervisor can be obtained through CPUID
> leaf 0x40000005. A virtual processor index must be less than the
> maximum number of virtual processors per partition.

Forbid userspace to set VP_INDEX above KVM_MAX_VCPUS. get_vcpu_by_vpidx()
can now be optimized to bail early when supplied vpidx is >= KVM_MAX_VCPUS.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
---
 arch/x86/kvm/hyperv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

```
#### [GIT PULL] Please pull my kvm-ppc-fixes-4.19-1 tag
##### From: Paul Mackerras <paulus@ozlabs.org>

```c
