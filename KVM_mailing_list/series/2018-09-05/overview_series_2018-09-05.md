#### [GIT PULL 1/3] KVM: s390: Fix pfmf and conditional skey emulation
##### From: Christian Borntraeger <borntraeger@de.ibm.com>

```c

From: Janosch Frank <frankja@linux.ibm.com>

We should not return with a lock.
We also have to increase the address when we do page clearing.

Fixes: bd096f644319 ("KVM: s390: Add skey emulation fault handling")
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Message-Id: <20180830081355.59234-1-frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

```
#### [PATCH kvm-unit-tests v3] arm/arm64: gicv3: support up to 8
##### From: Andrew Jones <drjones@redhat.com>

```c

We need to support at least two redistributor regions in order to
support more than 123 vcpus (we select 8 because that should be
plenty). Also bump NR_CPUS to 512, since that's what KVM currently
supports.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Tested-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
---
v3:
 - add missing '++i' to the main loop in gicv3_set_redist_base
   [Christoffer]
v2:
 - neater implementation by handling the number of redist regions
   more generally [Peter]

 lib/arm/asm/gic-v3.h |  3 +++
 lib/arm/asm/setup.h  |  2 +-
 lib/arm/gic-v3.c     | 24 ++++++++++++++----------
 lib/arm/gic.c        | 14 +++++++++-----
 4 files changed, 27 insertions(+), 16 deletions(-)

```
#### [RFC PATCH v2] migration: calculate remaining pages
##### From: Quan Xu <quan.xu0@gmail.com>

```c

From 7de4cc7c944bfccde0ef10992a7ec882fdcf0508 Mon Sep 17 00:00:00 2001
From: Quan Xu <quan.xu0@gmail.com>
Date: Wed, 5 Sep 2018 22:06:58 +0800
Subject: [RFC PATCH v2] migration: calculate remaining pages accurately 
during the bulk stage

Since the bulk stage assumes in (migration_bitmap_find_dirty) that every
page is dirty, initialize the number of dirty pages at the beggining of
the iteration and then decrease it for each processed page.

Signed-off-by: Quan Xu <quan.xu0@gmail.com>
---
  migration/ram.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

      }
@@ -2001,6 +2004,7 @@ static bool find_dirty_block(RAMState *rs, 
PageSearchStatus *pss, bool *again)
              /* Flag that we've looped */
              pss->complete_round = true;
              rs->ram_bulk_stage = false;
+            rs->ram_bulk_bytes = 0;
              if (migrate_use_xbzrle()) {
                  /* If xbzrle is on, stop using the data compression at 
this
                   * point. In theory, xbzrle can do better than 
compression.
@@ -2513,6 +2517,7 @@ static void ram_state_reset(RAMState *rs)
      rs->last_page = 0;
      rs->last_version = ram_list.version;
      rs->ram_bulk_stage = true;
+    rs->ram_bulk_bytes = ram_bytes_total();
  }

  #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -3308,7 +3313,7 @@ static void ram_save_pending(QEMUFile *f, void 
*opaque, uint64_t max_size,
          /* We can do postcopy, and all the data is postcopiable */
          *res_compatible += remaining_size;
      } else {
-        *res_precopy_only += remaining_size;
+        *res_precopy_only += remaining_size + rs->ram_bulk_bytes;
      }
  }

--
1.8.3.1

```
#### [PATCH] KVM: x86: adjust kvm_mmu_page member to save 8 bytes
##### From: Wei Yang <richard.weiyang@gmail.com>

```c

On a 64bits machine, struct is naturally aligned with 8 bytes. Since
kvm_mmu_page member *unsync* and *role* are less then 4 bytes, we can
rearrange the sequence to compace the struct.

As the comment shows, *role* and *gfn* are used to key the shadow page. In
order to keep the comment valid, this patch moves the *unsync* up and
exchange the position of *role* and *gfn*.

From /proc/slabinfo, it shows the size of kvm_mmu_page is 8 bytes less and
with one more object per slap after applying this patch.

    # name            <active_objs> <num_objs> <objsize> <objperslab>
    kvm_mmu_page_header      0           0       168         24

    kvm_mmu_page_header      0           0       160         25

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 arch/x86/include/asm/kvm_host.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

```
#### [kvm-unit-tests PATCH] x86: UMIP: Fix wrong print of CR4.UMIP bit
##### From: Liran Alon <liran.alon@oracle.com>

```c

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 x86/umip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

```
