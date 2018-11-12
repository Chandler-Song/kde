#### [RFC PATCH 1/5] iommu: Add APIs for IOMMU PASID management
##### From: Lu Baolu <baolu.lu@linux.intel.com>

```c
This adds APIs for IOMMU drivers and device drivers to manage
the PASIDs used for DMA transfer and translation. It bases on
I/O ASID allocator for PASID namespace management and relies
on vendor specific IOMMU drivers for paravirtual PASIDs.

Below APIs are added:

* iommu_pasid_init(pasid)
  - Initialize a PASID consumer. The vendor specific IOMMU
    drivers are able to set the PASID range imposed by IOMMU
    hardware through a callback in iommu_ops.

* iommu_pasid_exit(pasid)
  - The PASID consumer stops consuming any PASID.

* iommu_pasid_alloc(pasid, min, max, private, *ioasid)
  - Allocate a PASID and associate a @private data with this
    PASID. The PASID value is stored in @ioaisd if returning
    success.

* iommu_pasid_free(pasid, ioasid)
  - Free a PASID to the pool so that it could be consumed by
    others.

This also adds below helpers to lookup or iterate PASID items
associated with a consumer.

* iommu_pasid_for_each(pasid, func, data)
  - Iterate PASID items of the consumer identified by @pasid,
    and call @func() against each item. An error returned from
    @func() will break the iteration.

* iommu_pasid_find(pasid, ioasid)
  - Retrieve the private data associated with @ioasid.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/Kconfig |  1 +
 drivers/iommu/iommu.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 73 +++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)

```
