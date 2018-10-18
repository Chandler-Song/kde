#### [PATCH V7 3/5]  target-i386: add rtc 0x70 port as coalesced_pio
##### From: Peng Hao <peng.hao2@zte.com.cn>

```c
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/timer/mc146818rtc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

```
#### [RESEND PATCH V6 1/5]  target/i386 : add coalesced pio support
##### From: Peng Hao <peng.hao2@zte.com.cn>

```c
add coalesced_pio's struct and KVM_CAP_COALESCED_PIO header.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 accel/kvm/kvm-all.c       |  4 ++--
 linux-headers/linux/kvm.h | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

```
#### [PATCH v1 1/2] vfio: ccw: Merge BUSY and BOXED states
##### From: Pierre Morel <pmorel@linux.ibm.com>

```c
VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY have
identical actions for the same events.

Let's merge both into a single state to simplify the code.
We choose to keep VFIO_CCW_STATE_BUSY.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 7 +------
 drivers/s390/cio/vfio_ccw_private.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

```
