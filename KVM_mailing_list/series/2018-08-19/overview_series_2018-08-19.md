#### [PATCH 1/2] kvm: leverage change to adjust slots->used_slots in
##### From: Wei Yang <richard.weiyang@gmail.com>

```c

update_memslots() is only called by __kvm_set_memory_region(), in which
change is calculated to indicate the following behavior. With this
information, it is not necessary to do the calculation again in
update_memslots().

By encoding the number of slot adjustment in the lowest byte of change,
the slots->used_slots adjustment is accomplished by one addition.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/kvm_host.h | 11 +++++++----
 virt/kvm/kvm_main.c      | 14 ++++----------
 2 files changed, 11 insertions(+), 14 deletions(-)

```
#### [PATCH v4 11/16] x86/kvm: enable Hygon support to KVM infrastructure
##### From: Pu Wen <puwen@hygon.cn>

```c

Hygon Dhyana CPU has the SVM feature as AMD family 17h does.
Add Hygon support in the KVM infrastructure.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/kvm_emulate.h |  4 ++++
 arch/x86/include/asm/virtext.h     |  5 +++--
 arch/x86/kvm/emulate.c             | 11 ++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

```
