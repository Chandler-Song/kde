#### [PATCH kvmtool 1/2] kvm: Do not pause already paused vcpus
##### From: Julien Thierry <julien.thierry@arm.com>

```c
With the following sequence:
	kvm__pause();
	kvm__continue();
	kvm__pause();

There is a chance that not all paused threads have been resumed, and the
second kvm__pause will attempt to pause them again. Since the paused thread
is waiting to own the pause_lock, it won't write its second pause
notification. kvm__pause will be waiting for that notification while owning
pause_lock, so... deadlock.

Simple solution is not to try to pause thread that had not the chance to
resume.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 kvm-cpu.c | 4 +---
 kvm.c     | 5 ++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

```
#### [PATCH] KVM: PPC: Book3S HV: Don't use streamlined entry path on early POWER9 chips
##### From: Paul Mackerras <paulus@ozlabs.org>

```c
This disables the use of the streamlined entry path for radix guests
on early POWER9 chips that need the workaround added in commit
a25bd72badfa ("powerpc/mm/radix: Workaround prefetch issue with KVM",
2017-07-24), because the streamlined entry path does not include
that workaround.  This also means that we can't do nested HV-KVM
on those chips.

Since the chips that need that workaround are the same ones that can't
run both radix and HPT guests at the same time on different threads of
a core, we use the existing 'no_mixing_hpt_and_radix' variable that
identifies those chips to identify when we can't use the new guest
entry path, and when we can't do nested virtualization.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

```
#### [PATCH] KVM: PPC: Use exported tb_to_ns() function in decrementer emulation
##### From: Paul Mackerras <paulus@ozlabs.org>

```c
This changes the KVM code that emulates the decrementer function to do
the conversion of decrementer values to time intervals in nanoseconds
by calling the tb_to_ns() function exported by the powerpc timer code,
in preference to open-coded arithmetic using values from the
decrementer_clockevent struct.  Similarly, the HV-KVM code that did
the same conversion using arithmetic on tb_ticks_per_sec also now
uses tb_to_ns().

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 3 +--
 arch/powerpc/kvm/emulate.c   | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

```
