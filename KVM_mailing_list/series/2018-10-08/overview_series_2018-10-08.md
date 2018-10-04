#### [PATCH v2 1/2] arm/arm64: KVM: rename function kvm_arch_dev_ioctl_check_extension()
##### From: Dongjiu Geng <gengdongjiu@huawei.com>

```c
Rename kvm_arch_dev_ioctl_check_extension() to
kvm_arch_vm_ioctl_check_extension(), because it does
not have any relationship with device.

Renaming this function can make code readable.

Cc: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
I remeber James also mentioned that rename this function.
---
 arch/arm/include/asm/kvm_host.h   | 2 +-
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kvm/reset.c            | 4 ++--
 virt/kvm/arm/arm.c                | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

```
