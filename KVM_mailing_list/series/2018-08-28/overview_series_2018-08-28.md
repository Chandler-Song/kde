#### [PATCH v8 1/2] linux-headers: Update to kernel mainline commit
##### From: Dongjiu Geng <gengdongjiu@huawei.com>

```c

Update our kernel headers to mainline commit
815f0ddb346c196018d4d8f8f55c12b83da1de3f
(include/linux/compiler*.h: make compiler-*.h mutually exclusive)

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 include/standard-headers/linux/input.h |  9 +++++----
 linux-headers/asm-arm/kvm.h            | 13 +++++++++++++
 linux-headers/asm-arm64/kvm.h          | 13 +++++++++++++
 linux-headers/linux/kvm.h              |  1 +
 4 files changed, 32 insertions(+), 4 deletions(-)

```
