#### [PATCH v3 1/3] KVM: nVMX: Do not expose MPX VMX controls when guest
##### From: Liran Alon <liran.alon@oracle.com>

```c

Before this commit, KVM exposes MPX VMX controls to L1 guest only based
on if KVM and host processor supports MPX virtualization.
However, these controls should be exposed to guest only in case guest
vCPU supports MPX.

Without this change, a L1 guest running with kernel which don't have
commit 691bd4340bef ("kvm: vmx: allow host to access guest
MSR_IA32_BNDCFGS") asserts in QEMU on the following:
	qemu-kvm: error: failed to set MSR 0xd90 to 0x0
	qemu-kvm: .../qemu-2.10.0/target/i386/kvm.c:1801 kvm_put_msrs:
	Assertion 'ret == cpu->kvm_msr_buf->nmsrs failed'
This is because L1 KVM kvm_init_msr_list() will see that
vmx_mpx_supported() (As it only checks MPX VMX controls support) and
therefore KVM_GET_MSR_INDEX_LIST IOCTL will include MSR_IA32_BNDCFGS.
However, later when L1 will attempt to set this MSR via KVM_SET_MSRS
IOCTL, it will fail because !guest_cpuid_has_mpx(vcpu).

Therefore, fix the issue by exposing MPX VMX controls to L1 guest only
when vCPU supports MPX.

Fixes: 36be0b9deb23 ("KVM: x86: Add nested virtualization support for MPX")

Reported-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/kvm/vmx.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

```
#### [PATCH 1/2] i386: Compile CPUX86State xsave_buf only when support KVM
##### From: Liran Alon <liran.alon@oracle.com>

```c

While at it, also rename var to indicate it is not used only in KVM.

Reviewed-by: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Reviewed-by: Patrick Colp <patrick.colp@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/cpu.h         | 4 +++-
 target/i386/hvf/README.md | 2 +-
 target/i386/hvf/hvf.c     | 2 +-
 target/i386/hvf/x86hvf.c  | 4 ++--
 target/i386/kvm.c         | 6 +++---
 5 files changed, 10 insertions(+), 8 deletions(-)

```
#### [PATCH] vfio/mdev: fix missed mdev free in mdev_device_create() error
##### From: Zhenyu Wang <zhenyuw@linux.intel.com>

```c

Add mdev kfree in mdev_device_create() error path which seems
to be ignored.

Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 drivers/vfio/mdev/mdev_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

```
#### [GIT PULL] Please pull my kvm-ppc-fixes-4.19-2 tag
##### From: Paul Mackerras <paulus@ozlabs.org>

```c
