#### [PATCH] kvm: mmu: Don't read PDPTEs when paging is not enabled
##### From: Junaid Shahid <junaids@google.com>

```c

kvm should not attempt to read guest PDPTEs when CR0.PG = 0 and
CR4.PAE = 1.

Signed-off-by: Junaid Shahid <junaids@google.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

```
#### [PATCH V3 1/4] kvm: remove redundant reserved page check
##### From: Zhang Yi <yi.z.zhang@linux.intel.com>

```c

PageReserved() is already checked inside kvm_is_reserved_pfn(),
remove it from kvm_set_pfn_dirty().

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
Acked-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 virt/kvm/kvm_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

```
#### [patch 1/2] KVM: x86: switch KVMCLOCK base to CLOCK_MONOTONIC_RAW
##### From: Marcelo Tosatti <mtosatti@redhat.com>

```c
