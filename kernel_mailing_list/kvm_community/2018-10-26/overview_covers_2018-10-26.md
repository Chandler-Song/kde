

#### [kvm PATCH v4 0/2] use vmalloc to allocate vmx vcpus
##### From: Marc Orr <marcorr@google.com>

```c

A couple of patches to allocate vmx vcpus with vmalloc instead of
kalloc, which enables vcpu allocation to succeeed when contiguous
physical memory is sparse.

Compared to the last version of these patches, this version:
1. Splits out the refactoring of the vmx_msrs struct into it's own
patch, as suggested by Sean Christopherson <sean.j.christopherson@intel.com>.
2. Leverages the __vmalloc() API rather than introducing a new vzalloc()
API, as suggested by Michal Hocko <mhocko@kernel.org>.

Marc Orr (2):
  kvm: vmx: refactor vmx_msrs struct for vmalloc
  kvm: vmx: use vmalloc() to allocate vcpus

 arch/x86/kvm/vmx.c  | 92 +++++++++++++++++++++++++++++++++++++++++----
 virt/kvm/kvm_main.c | 28 ++++++++------
 2 files changed, 100 insertions(+), 20 deletions(-)
```
