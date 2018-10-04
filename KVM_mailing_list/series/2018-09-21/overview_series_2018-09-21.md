#### [PATCH v3 1/2] vfio: add edid api for display (vgpu) devices.
##### From: Gerd Hoffmann <kraxel@redhat.com>

```c

This allows to set EDID monitor information for the vgpu display, for a
more flexible display configuration, using a special vfio region.  Check
the comment describing struct vfio_region_gfx_edid for more details.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/vfio.h | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

```
#### [RFC PATCH 01/32] KVM: PPC: Book3S: Simplify external interrupt
##### From: Paul Mackerras <paulus@ozlabs.org>

```c

Currently we use two bits in the vcpu pending_exceptions bitmap to
indicate that an external interrupt is pending for the guest, one
for "one-shot" interrupts that are cleared when delivered, and one
for interrupts that persist until cleared by an explicit action of
the OS (e.g. an acknowledge to an interrupt controller).  The
BOOK3S_IRQPRIO_EXTERNAL bit is used for one-shot interrupt requests
and BOOK3S_IRQPRIO_EXTERNAL_LEVEL is used for persisting interrupts.

In practice BOOK3S_IRQPRIO_EXTERNAL never gets used, because our
Book3S platforms generally, and pseries in particular, expect
external interrupt requests to persist until they are acknowledged
at the interrupt controller.  That combined with the confusion
introduced by having two bits for what is essentially the same thing
makes it attractive to simplify things by only using one bit.  This
patch does that.

With this patch there is only BOOK3S_IRQPRIO_EXTERNAL, and by default
it has the semantics of a persisting interrupt.  In order to avoid
breaking the ABI, we introduce a new "external_oneshot" flag which
preserves the behaviour of the KVM_INTERRUPT ioctl with the
KVM_INTERRUPT_SET argument.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_asm.h             |  4 +--
 arch/powerpc/include/asm/kvm_host.h            |  1 +
 arch/powerpc/kvm/book3s.c                      | 43 ++++++++++++++++++++------
 arch/powerpc/kvm/book3s_hv_rm_xics.c           |  5 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |  4 +--
 arch/powerpc/kvm/book3s_pr.c                   |  1 -
 arch/powerpc/kvm/book3s_xics.c                 | 11 +++----
 arch/powerpc/kvm/book3s_xive_template.c        |  2 +-
 arch/powerpc/kvm/trace_book3s.h                |  1 -
 tools/perf/arch/powerpc/util/book3s_hv_exits.h |  1 -
 10 files changed, 44 insertions(+), 29 deletions(-)

```
#### [PULL kvm-unit-tests] arm/arm64: patches ready for master
##### From: Andrew Jones <drjones@redhat.com>

```c
