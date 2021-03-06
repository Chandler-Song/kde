#### [GIT PULL] First batch of KVM changes for 4.19-rc1
##### From: Paolo Bonzini <pbonzini@redhat.com>

```c
Linus,

The following changes since commit a449938297e55e7e8958f8b48583f7d342da1930:

  KVM: s390: Add huge page enablement control (2018-07-30 23:13:38 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 28a1f3ac1d0c8558ee4453d9634dad891a6e922e:

  kvm: x86: Set highest physical address bits in non-present/reserved SPTEs (2018-08-14 19:25:59 +0200)

----------------------------------------------------------------
Minor code cleanups for PPC.

For x86 this brings in PCID emulation and CR3 caching for shadow page
tables, nested VMX live migration, nested VMCS shadowing, an optimized
IPI hypercall, and some optimizations.

ARM will come next week.

There is a semantic conflict because tip also added an .init_platform
callback to kvm.c.  Please keep the initializer from this branch,
and add a call to kvmclock_init (added by tip) inside kvm_init_platform
(added here).

Also, there is a backmerge from 4.18-rc6.  This is because of a
refactoring that conflicted with a relatively late bugfix and
resulted in a particularly hellish conflict.  Because the conflict
was only due to unfortunate timing of the bugfix, I backmerged and
rebased the refactoring rather than force the resolution on you.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      KVM: PPC: Book3S: Fix matching of hardware and emulated TCE tables

Christian Borntraeger (2):
      KVM: s390/vsie: avoid sparse warning
      KVM: s390: add etoken support for guests

Claudio Imbrenda (2):
      KVM: s390: a utility function for migration
      KVM: s390: Fix storage attributes migration with memory slots

Janosch Frank (3):
      KVM: s390: Replace clear_user with kvm_clear_guest
      KVM: s390: Beautify skey enable check
      Merge tag 'hlp_stage1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvms390/next

Jim Mattson (3):
      kvm: nVMX: Introduce KVM_CAP_NESTED_STATE
      kvm: nVMX: Fix fault vector for VMX operation at CPL > 0
      kvm: nVMX: Fix fault priority for VMX operations

Junaid Shahid (19):
      kvm: x86: Make sync_page() flush remote TLBs once only
      kvm: x86: Avoid taking MMU lock in kvm_mmu_sync_roots if no sync is needed
      kvm: x86: Add fast CR3 switch code path
      kvm: x86: Introduce kvm_mmu_calc_root_page_role()
      kvm: x86: Introduce KVM_REQ_LOAD_CR3
      kvm: x86: Add support for fast CR3 switch across different MMU modes
      kvm: x86: Support resetting the MMU context without resetting roots
      kvm: x86: Use fast CR3 switch for nested VMX
      kvm: x86: Add ability to skip TLB flush when switching CR3
      kvm: x86: Propagate guest PCIDs to host PCIDs
      kvm: vmx: Support INVPCID in shadow paging mode
      kvm: x86: Skip TLB flush on fast CR3 switch when indicated by guest
      kvm: x86: Add a root_hpa parameter to kvm_mmu->invlpg()
      kvm: x86: Support selectively freeing either current or previous MMU root
      kvm: x86: Skip shadow page resync on CR3 switch when indicated by guest
      kvm: x86: Flush only affected TLB entries in kvm_mmu_invlpg*
      kvm: x86: Add multi-entry LRU cache for previous CR3s
      kvm: x86: Remove CR3_PCID_INVD flag
      kvm: x86: Set highest physical address bits in non-present/reserved SPTEs

KarimAllah Ahmed (1):
      KVM: Switch 'requests' to be 64-bit (explicitly)

Liang Chen (1):
      KVM: x86: Skip pae_root shadow allocation if tdp enabled

Liran Alon (13):
      KVM: VMX: Create struct for VMCS header
      KVM: VMX: Change vmcs12_{read,write}_any() to receive vmcs12 as parameter
      KVM: nVMX: Allow VMPTRLD for shadow VMCS if vCPU supports VMCS shadowing
      KVM: nVMX: Fail VMLAUNCH and VMRESUME on shadow VMCS
      KVM: nVMX: Introduce nested_cpu_has_shadow_vmcs()
      KVM: nVMX: Verify VMCS shadowing controls
      KVM: nVMX: Verify VMCS shadowing VMCS link pointer
      KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush to memory on VMExit
      KVM: nVMX: vmread/vmwrite: Use shadow vmcs12 if running L2
      KVM: nVMX: Do not forward VMREAD/VMWRITE VMExits to L1 if required so by vmcs12 vmread/vmwrite bitmaps
      KVM: nVMX: Expose VMCS shadowing to L1 guest
      KVM: VMX: Mark vmcs header as shadow in case alloc_vmcs_cpu() allocate shadow vmcs
      KVM: nVMX: Separate logic allocating shadow vmcs to a function

Nicholas Mc Guire (2):
      KVM: PPC: Book3S HV: Add of_node_put() in success path
      KVM: PPC: Book3S HV: Fix constant size warning

Paolo Bonzini (13):
      Merge tag 'kvm-ppc-next-4.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into HEAD
      Merge tag 'kvm-s390-next-4.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'v4.18-rc6' into HEAD
      KVM: x86: ensure all MSRs can always be KVM_GET/SET_MSR'd
      kvm: selftests: create a GDT and TSS
      kvm: selftests: actually use all of lib/vmx.c
      kvm: selftests: ensure vcpu file is released
      kvm: selftests: add basic test for state save and restore
      KVM: x86: do not load vmcs12 pages while still in SMM
      kvm: selftests: add test for nested state save/restore
      KVM: nVMX: include shadow vmcs12 in nested state
      KVM: selftests: add tests for shadow VMCS save/restore
      KVM: try __get_user_pages_fast even if not in atomic context

Paul Mackerras (2):
      KVM: PPC: Book3S HV: Allow creating max number of VCPUs on POWER9
      KVM: PPC: Book3S HV: Read kvm->arch.emul_smt_mode under kvm->lock

Peter Xu (1):
      KVM: MMU: drop vcpu param in gpte_access

Sam Bobroff (1):
      KVM: PPC: Book3S HV: Pack VCORE IDs to access full VCPU ID space

Sean Christopherson (11):
      KVM: vmx: remove save/restore of host BNDCGFS MSR
      KVM: vmx: refactor segmentation code in vmx_save_host_state()
      KVM: vmx: track host_state.loaded using a loaded_vmcs pointer
      KVM: vmx: add dedicated utility to access guest's kernel_gs_base
      KVM: vmx: rename __vmx_load_host_state() and vmx_save_host_state()
      KVM: nVMX: remove a misleading comment regarding vmcs02 fields
      KVM: vmx: compute need to reload FS/GS/LDT on demand
      KVM: vmx: move struct host_state usage to struct loaded_vmcs
      KVM: vmx: always initialize HOST_{FS,GS}_BASE to zero during setup
      KVM: vmx: skip VMWRITE of HOST_{FS,GS}_SEL when possible
      KVM: vmx: skip VMWRITE of HOST_{FS,GS}_BASE when possible

Simon Guo (1):
      KVM: PPC: Remove mmio_vsx_tx_sx_enabled in KVM MMIO emulation

Tianyu Lan (7):
      KVM/MMU: Simplify __kvm_sync_page() function
      X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall support
      X86/Hyper-V: Add hyperv_nested_flush_guest_mapping ftrace support
      KVM: x86: Add tlb remote flush callback in kvm_x86_ops.
      KVM: vmx: Add tlb_remote_flush callback support
      KVM/MMU: Combine flushing remote tlb in mmu_set_spte()
      KVM/x86: Move X86_CR4_OSXSAVE check into kvm_valid_sregs()

Uros Bizjak (1):
      KVM/x86: Use CC_SET()/CC_OUT in arch/x86/kvm/vmx.c

Waiman Long (1):
      x86/kvm: Don't use pvqspinlock code if only 1 vCPU

Wanpeng Li (3):
      KVM: X86: Implement "send IPI" hypercall
      KVM: X86: Add kvm hypervisor init time platform setup callback
      KVM: X86: Implement PV IPIs in linux guest

Wei Huang (1):
      kvm: selftests: add cr4_cpuid_sync_test

 Documentation/admin-guide/kernel-parameters.txt    |    5 +
 Documentation/admin-guide/pm/intel_pstate.rst      |   14 +-
 Documentation/device-mapper/writecache.txt         |    2 +
 .../bindings/arm/samsung/samsung-boards.txt        |    2 +-
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |    2 +-
 .../bindings/gpio/nintendo,hollywood-gpio.txt      |    2 +-
 .../bindings/input/sprd,sc27xx-vibra.txt           |   23 +
 .../bindings/input/touchscreen/hideep.txt          |    2 +-
 .../interrupt-controller/nvidia,tegra20-ictlr.txt  |    2 +-
 .../interrupt-controller/st,stm32-exti.txt         |    2 +-
 .../devicetree/bindings/mips/brcm/soc.txt          |    2 +-
 Documentation/devicetree/bindings/net/fsl-fman.txt |    2 +-
 .../devicetree/bindings/power/power_domain.txt     |    2 +-
 .../devicetree/bindings/regulator/tps65090.txt     |    2 +-
 .../devicetree/bindings/reset/st,sti-softreset.txt |    2 +-
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |    2 +-
 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt |    2 +-
 .../devicetree/bindings/sound/qcom,apq8096.txt     |    2 +-
 Documentation/devicetree/bindings/w1/w1-gpio.txt   |    2 +-
 Documentation/filesystems/Locking                  |    7 +-
 Documentation/filesystems/vfs.txt                  |   13 -
 Documentation/kbuild/kbuild.txt                    |   17 +-
 Documentation/kbuild/kconfig-language.txt          |    6 +
 Documentation/kbuild/kconfig.txt                   |   51 +-
 Documentation/networking/bonding.txt               |    2 +-
 Documentation/networking/e100.rst                  |  131 +--
 Documentation/networking/e1000.rst                 |  149 ++-
 Documentation/networking/strparser.txt             |    2 +-
 Documentation/usb/gadget_configfs.txt              |    2 +-
 Documentation/virtual/kvm/api.txt                  |   56 +
 Documentation/virtual/kvm/cpuid.txt                |    4 +
 Documentation/virtual/kvm/hypercalls.txt           |   20 +
 MAINTAINERS                                        |   46 +-
 Makefile                                           |   15 +-
 arch/alpha/kernel/osf_sys.c                        |    5 +-
 arch/arc/Kconfig                                   |    2 +-
 arch/arc/Makefile                                  |   15 +-
 arch/arc/configs/axs101_defconfig                  |    1 -
 arch/arc/configs/axs103_defconfig                  |    1 -
 arch/arc/configs/axs103_smp_defconfig              |    1 -
 arch/arc/configs/haps_hs_defconfig                 |    1 -
 arch/arc/configs/haps_hs_smp_defconfig             |    1 -
 arch/arc/configs/hsdk_defconfig                    |    1 -
 arch/arc/configs/nsim_700_defconfig                |    1 -
 arch/arc/configs/nsim_hs_defconfig                 |    1 -
 arch/arc/configs/nsim_hs_smp_defconfig             |    1 -
 arch/arc/configs/nsimosci_defconfig                |    1 -
 arch/arc/configs/nsimosci_hs_defconfig             |    1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig         |    1 -
 arch/arc/configs/tb10x_defconfig                   |    1 -
 arch/arc/include/asm/entry-compact.h               |    6 +
 arch/arc/include/asm/entry.h                       |    3 -
 arch/arc/include/asm/mach_desc.h                   |    2 -
 arch/arc/include/asm/page.h                        |    2 +-
 arch/arc/include/asm/pgtable.h                     |    2 +-
 arch/arc/kernel/irq.c                              |    2 +-
 arch/arc/kernel/process.c                          |   47 +-
 arch/arc/plat-hsdk/Kconfig                         |    3 +
 arch/arc/plat-hsdk/platform.c                      |   62 ++
 arch/arm/Kconfig                                   |    8 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |    1 -
 arch/arm/boot/dts/am3517.dtsi                      |    9 +
 arch/arm/boot/dts/am437x-sk-evm.dts                |    2 +
 arch/arm/boot/dts/armada-385-synology-ds116.dts    |    2 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |    2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   24 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |   24 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   32 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |    2 +-
 arch/arm/boot/dts/da850.dtsi                       |    6 +-
 arch/arm/boot/dts/dra7.dtsi                        |    2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |    2 +-
 arch/arm/boot/dts/imx6q.dtsi                       |    2 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |    2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |    2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |    9 +-
 arch/arm/boot/dts/socfpga.dtsi                     |    4 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |    5 +-
 arch/arm/common/Makefile                           |    2 +-
 arch/arm/configs/imx_v4_v5_defconfig               |    2 +
 arch/arm/configs/imx_v6_v7_defconfig               |    2 +
 arch/arm/configs/multi_v7_defconfig                |  378 +++----
 arch/arm/crypto/speck-neon-core.S                  |    6 +-
 arch/arm/firmware/Makefile                         |    3 +
 arch/arm/kernel/head-nommu.S                       |    2 +-
 arch/arm/mach-bcm/Kconfig                          |    1 +
 arch/arm/mach-davinci/board-da850-evm.c            |    2 +-
 arch/arm/mach-omap2/omap-smp.c                     |   41 +
 arch/arm/mach-pxa/irq.c                            |    4 +-
 arch/arm/mach-socfpga/Kconfig                      |    1 +
 arch/arm/mm/init.c                                 |    9 +
 arch/arm/net/bpf_jit_32.c                          |    2 +-
 arch/arm64/Makefile                                |   10 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |    6 +-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |   15 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |    4 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   12 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi    |    2 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |    3 -
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |    7 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |    8 -
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |    8 +-
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |    4 +
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |    4 +
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |    4 +-
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |    2 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |    2 +
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |    2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |    2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |    4 +-
 .../boot/dts/socionext/uniphier-ld11-global.dts    |    2 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts    |    2 +-
 arch/arm64/configs/defconfig                       |  102 +-
 arch/arm64/include/asm/alternative.h               |    7 +-
 arch/arm64/include/asm/pgtable.h                   |    6 +-
 arch/arm64/include/asm/simd.h                      |   19 +-
 arch/arm64/kernel/alternative.c                    |   51 +-
 arch/arm64/kernel/module.c                         |    5 +-
 arch/ia64/kernel/perfmon.c                         |    6 +-
 arch/ia64/mm/init.c                                |   12 +-
 arch/m68k/include/asm/mcf_pgalloc.h                |    4 +-
 arch/microblaze/Kconfig.debug                      |    7 -
 arch/microblaze/include/asm/setup.h                |    5 -
 arch/microblaze/include/asm/unistd.h               |    2 +-
 arch/microblaze/include/uapi/asm/unistd.h          |    2 +
 arch/microblaze/kernel/Makefile                    |    4 +-
 arch/microblaze/kernel/heartbeat.c                 |   72 --
 arch/microblaze/kernel/platform.c                  |   29 -
 arch/microblaze/kernel/reset.c                     |   11 +-
 arch/microblaze/kernel/syscall_table.S             |    2 +
 arch/microblaze/kernel/timer.c                     |    7 -
 arch/mips/kernel/process.c                         |   43 +-
 arch/mips/kernel/signal.c                          |    4 +-
 arch/mips/kernel/traps.c                           |    1 +
 arch/mips/mm/ioremap.c                             |   37 +-
 arch/nds32/Kconfig                                 |   12 +-
 arch/nds32/Makefile                                |    2 +
 arch/nds32/include/asm/cacheflush.h                |    9 +-
 arch/nds32/include/asm/futex.h                     |    2 +-
 arch/nds32/kernel/setup.c                          |    3 +-
 arch/nds32/mm/cacheflush.c                         |  100 +-
 arch/openrisc/include/asm/pgalloc.h                |    6 +-
 arch/openrisc/kernel/entry.S                       |    8 +-
 arch/openrisc/kernel/head.S                        |    9 +-
 arch/openrisc/kernel/traps.c                       |    2 +-
 arch/parisc/Kconfig                                |    6 +-
 arch/parisc/Makefile                               |    4 -
 arch/parisc/include/asm/signal.h                   |    8 -
 arch/parisc/include/uapi/asm/unistd.h              |    3 +-
 arch/parisc/kernel/drivers.c                       |   25 +-
 arch/parisc/kernel/syscall_table.S                 |    1 +
 arch/parisc/kernel/unwind.c                        |    4 +-
 arch/powerpc/Makefile                              |    1 +
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |    1 -
 arch/powerpc/include/asm/kvm_book3s.h              |   47 +
 arch/powerpc/include/asm/kvm_host.h                |   26 +-
 arch/powerpc/include/asm/mmu_context.h             |    4 +-
 arch/powerpc/include/asm/nohash/32/pgalloc.h       |    1 -
 arch/powerpc/include/asm/reg.h                     |    2 +-
 arch/powerpc/include/asm/systbl.h                  |    1 +
 arch/powerpc/include/asm/unistd.h                  |    2 +-
 arch/powerpc/include/uapi/asm/unistd.h             |    1 +
 arch/powerpc/kernel/idle_book3s.S                  |    2 +
 arch/powerpc/kernel/pci_32.c                       |    4 -
 arch/powerpc/kernel/pci_64.c                       |    4 -
 arch/powerpc/kernel/rtas.c                         |    4 -
 arch/powerpc/kernel/signal_32.c                    |    8 -
 arch/powerpc/kernel/signal_64.c                    |    4 -
 arch/powerpc/kernel/syscalls.c                     |    4 -
 arch/powerpc/kvm/book3s_64_vio.c                   |    7 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |    6 +-
 arch/powerpc/kvm/book3s_hv.c                       |   42 +-
 arch/powerpc/kvm/book3s_xive.c                     |   19 +-
 arch/powerpc/kvm/emulate_loadstore.c               |    7 +-
 arch/powerpc/kvm/powerpc.c                         |   30 +-
 arch/powerpc/mm/mmu_context_iommu.c                |   37 +-
 arch/powerpc/mm/subpage-prot.c                     |    4 -
 arch/powerpc/platforms/powermac/time.c             |   29 +-
 arch/powerpc/xmon/xmon.c                           |    4 +-
 arch/riscv/Kconfig                                 |    1 +
 arch/riscv/include/uapi/asm/elf.h                  |    9 +-
 arch/riscv/kernel/irq.c                            |    4 -
 arch/riscv/kernel/module.c                         |   26 +-
 arch/riscv/kernel/ptrace.c                         |    2 +-
 arch/riscv/kernel/setup.c                          |    5 -
 arch/riscv/mm/init.c                               |    2 +
 arch/s390/Kconfig                                  |    1 +
 arch/s390/include/asm/kvm_host.h                   |   11 +-
 arch/s390/include/uapi/asm/kvm.h                   |    5 +-
 arch/s390/kernel/compat_wrapper.c                  |    1 +
 arch/s390/kernel/entry.S                           |    8 +-
 arch/s390/kernel/signal.c                          |    3 +-
 arch/s390/kernel/syscalls/syscall.tbl              |    2 +
 arch/s390/kvm/kvm-s390.c                           |  301 +++---
 arch/s390/kvm/priv.c                               |   40 +-
 arch/s390/kvm/vsie.c                               |   11 +-
 arch/s390/mm/pgalloc.c                             |    4 +
 arch/s390/net/bpf_jit_comp.c                       |    1 +
 arch/s390/tools/gen_facilities.c                   |    3 +-
 arch/x86/Kconfig                                   |    2 +-
 arch/x86/boot/compressed/eboot.c                   |   12 +-
 arch/x86/crypto/aegis128-aesni-asm.S               |    1 +
 arch/x86/crypto/aegis128l-aesni-asm.S              |    1 +
 arch/x86/crypto/aegis256-aesni-asm.S               |    1 +
 arch/x86/crypto/morus1280-avx2-asm.S               |    1 +
 arch/x86/crypto/morus1280-sse2-asm.S               |    1 +
 arch/x86/crypto/morus640-sse2-asm.S                |    1 +
 arch/x86/entry/entry_32.S                          |    2 +-
 arch/x86/entry/entry_64_compat.S                   |   16 +-
 arch/x86/events/intel/ds.c                         |    8 +-
 arch/x86/hyperv/Makefile                           |    2 +-
 arch/x86/hyperv/hv_apic.c                          |    5 +
 arch/x86/hyperv/hv_init.c                          |    5 +-
 arch/x86/hyperv/nested.c                           |   56 +
 arch/x86/include/asm/apm.h                         |    6 -
 arch/x86/include/asm/asm.h                         |   59 +
 arch/x86/include/asm/hyperv-tlfs.h                 |    8 +
 arch/x86/include/asm/irqflags.h                    |    2 +-
 arch/x86/include/asm/kvm_host.h                    |   56 +-
 arch/x86/include/asm/mshyperv.h                    |    7 +-
 arch/x86/include/asm/pgalloc.h                     |    3 +
 arch/x86/include/asm/pgtable.h                     |    2 +-
 arch/x86/include/asm/pgtable_64.h                  |    4 +-
 arch/x86/include/asm/trace/hyperv.h                |   14 +
 arch/x86/include/asm/uaccess_64.h                  |    7 +-
 arch/x86/include/uapi/asm/kvm.h                    |   37 +
 arch/x86/include/uapi/asm/kvm_para.h               |    1 +
 arch/x86/kernel/Makefile                           |    1 +
 arch/x86/kernel/apm_32.c                           |    5 +
 arch/x86/kernel/cpu/amd.c                          |    4 +-
 arch/x86/kernel/cpu/bugs.c                         |    8 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |    3 -
 arch/x86/kernel/cpu/mtrr/if.c                      |    3 +-
 arch/x86/kernel/e820.c                             |   15 +-
 arch/x86/kernel/irqflags.S                         |   26 +
 arch/x86/kernel/kvm.c                              |  110 ++
 arch/x86/kernel/kvmclock.c                         |   12 +-
 arch/x86/kernel/smpboot.c                          |    5 +
 arch/x86/kvm/Kconfig                               |    2 +-
 arch/x86/kvm/cpuid.c                               |    3 +-
 arch/x86/kvm/emulate.c                             |    2 +-
 arch/x86/kvm/hyperv.c                              |   27 +-
 arch/x86/kvm/hyperv.h                              |    2 +-
 arch/x86/kvm/lapic.c                               |   40 +
 arch/x86/kvm/mmu.c                                 |  531 +++++++--
 arch/x86/kvm/mmu.h                                 |   24 +-
 arch/x86/kvm/paging_tmpl.h                         |   28 +-
 arch/x86/kvm/svm.c                                 |   12 +-
 arch/x86/kvm/vmx.c                                 | 1141 ++++++++++++++++----
 arch/x86/kvm/x86.c                                 |  112 +-
 arch/x86/mm/fault.c                                |   21 +-
 arch/x86/platform/efi/efi_64.c                     |    4 +-
 arch/x86/purgatory/Makefile                        |    2 +-
 arch/x86/xen/enlighten_pv.c                        |   25 +-
 arch/x86/xen/irq.c                                 |    4 +-
 block/blk-core.c                                   |    4 +
 block/blk-mq.c                                     |   12 +
 block/bsg.c                                        |    2 -
 certs/blacklist.h                                  |    2 +-
 crypto/af_alg.c                                    |   17 +-
 crypto/algif_aead.c                                |    4 +-
 crypto/algif_skcipher.c                            |    4 +-
 crypto/asymmetric_keys/x509_cert_parser.c          |    9 +
 drivers/acpi/acpica/hwsleep.c                      |   15 +-
 drivers/acpi/acpica/uterror.c                      |    6 +-
 drivers/acpi/battery.c                             |    9 +-
 drivers/acpi/ec.c                                  |    2 +-
 drivers/acpi/nfit/core.c                           |   48 +-
 drivers/acpi/nfit/nfit.h                           |    1 +
 drivers/acpi/osl.c                                 |   72 ++
 drivers/acpi/pptt.c                                |   10 +-
 drivers/ata/Kconfig                                |    2 -
 drivers/ata/ahci.c                                 |   60 +
 drivers/ata/ahci_mvebu.c                           |    2 +-
 drivers/ata/libahci.c                              |    7 +-
 drivers/ata/libata-core.c                          |    3 +
 drivers/ata/libata-eh.c                            |   41 +-
 drivers/ata/libata-scsi.c                          |   18 +-
 drivers/ata/sata_fsl.c                             |    9 +-
 drivers/ata/sata_nv.c                              |    3 -
 drivers/atm/iphase.c                               |    2 +-
 drivers/atm/zatm.c                                 |    2 +
 drivers/base/power/domain.c                        |   23 +-
 drivers/block/drbd/drbd_req.c                      |    4 +-
 drivers/block/drbd/drbd_worker.c                   |    2 +-
 drivers/block/loop.c                               |    1 +
 drivers/bus/ti-sysc.c                              |    8 +-
 drivers/char/agp/alpha-agp.c                       |    2 +-
 drivers/char/agp/amd64-agp.c                       |    4 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |    6 +-
 drivers/char/ipmi/kcs_bmc.c                        |   31 +-
 drivers/char/random.c                              |   29 +-
 drivers/clk/Makefile                               |    2 +-
 drivers/clk/davinci/da8xx-cfgchip.c                |    2 +-
 drivers/clk/davinci/psc.h                          |    2 +-
 drivers/clk/sunxi-ng/Makefile                      |   39 +-
 drivers/clocksource/arm_arch_timer.c               |    2 +-
 drivers/cpufreq/intel_pstate.c                     |   17 +-
 drivers/cpufreq/pcc-cpufreq.c                      |    4 +
 drivers/cpufreq/qcom-cpufreq-kryo.c                |    8 +-
 drivers/dax/device.c                               |   12 +-
 drivers/dax/super.c                                |    8 +
 drivers/dma/k3dma.c                                |    2 +-
 drivers/dma/pl330.c                                |    2 +-
 drivers/dma/ti/omap-dma.c                          |    6 +-
 drivers/fpga/altera-cvp.c                          |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   47 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  131 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   12 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |    4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   65 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |   10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |    8 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |   27 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |   19 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |    2 +
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |    5 +-
 drivers/gpu/drm/amd/include/atomfirmware.h         |    5 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |   96 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h |    5 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |    4 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |    3 +
 .../amd/powerplay/hwmgr/vega12_processpptables.c   |    2 +
 .../drm/amd/powerplay/inc/vega12/smu9_driver_if.h  |    5 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |   23 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |    3 +-
 drivers/gpu/drm/arm/malidp_hw.c                    |    3 +-
 drivers/gpu/drm/arm/malidp_planes.c                |    9 +-
 drivers/gpu/drm/armada/armada_crtc.c               |   12 +-
 drivers/gpu/drm/armada/armada_hw.h                 |    1 +
 drivers/gpu/drm/armada/armada_overlay.c            |   30 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |   86 +-
 drivers/gpu/drm/drm_lease.c                        |   16 +-
 drivers/gpu/drm/drm_property.c                     |    6 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |   24 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |    3 +
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |   24 +
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |    6 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.c             |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c           |   17 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |   10 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   51 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.c            |  110 +-
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |   44 +-
 drivers/gpu/drm/exynos/regs-gsc.h                  |    1 +
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   23 +
 drivers/gpu/drm/i915/gvt/display.c                 |    6 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |   58 +
 drivers/gpu/drm/i915/gvt/gtt.h                     |    2 +
 drivers/gpu/drm/i915/gvt/gvt.h                     |   29 +
 drivers/gpu/drm/i915/gvt/handlers.c                |   24 +
 drivers/gpu/drm/i915/gvt/mmio.h                    |    2 +
 drivers/gpu/drm/i915/gvt/mmio_context.c            |    4 +-
 drivers/gpu/drm/i915/i915_drv.h                    |    3 -
 drivers/gpu/drm/i915/i915_gem.c                    |   28 +-
 drivers/gpu/drm/i915/i915_irq.c                    |   32 +-
 drivers/gpu/drm/i915/i915_vma.c                    |    2 +-
 drivers/gpu/drm/meson/meson_drv.c                  |   12 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.c            |    3 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   53 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |    6 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |    9 +-
 drivers/gpu/drm/nouveau/nouveau_connector.h        |   36 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |   10 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   18 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |    4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c      |    3 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp100.c     |    9 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp102.c     |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |    2 +
 drivers/gpu/drm/sun4i/Makefile                     |    5 +-
 drivers/gpu/drm/tegra/drm.c                        |    2 +-
 drivers/gpu/drm/udl/udl_fb.c                       |    5 +-
 drivers/gpu/drm/udl/udl_transfer.c                 |   11 +-
 drivers/gpu/host1x/dev.c                           |    3 +
 drivers/gpu/host1x/job.c                           |    3 +-
 drivers/hid/hid-core.c                             |    5 +-
 drivers/hid/hid-debug.c                            |    8 +-
 drivers/hid/i2c-hid/i2c-hid.c                      |    2 +-
 drivers/hid/usbhid/hiddev.c                        |   11 +
 drivers/hid/wacom_wac.c                            |   10 +-
 drivers/i2c/algos/i2c-algo-bit.c                   |    8 +-
 drivers/i2c/busses/i2c-cht-wc.c                    |    3 +-
 drivers/i2c/busses/i2c-gpio.c                      |    4 +-
 drivers/i2c/busses/i2c-stu300.c                    |    2 +-
 drivers/i2c/busses/i2c-tegra.c                     |   17 +-
 drivers/i2c/i2c-core-base.c                        |   11 +-
 drivers/i2c/i2c-core-smbus.c                       |   14 +-
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    2 +
 drivers/iio/light/tsl2772.c                        |    2 +
 drivers/iio/pressure/bmp280-core.c                 |    5 +-
 drivers/infiniband/core/uverbs_cmd.c               |   28 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |    2 +-
 drivers/infiniband/hw/hfi1/rc.c                    |    2 +-
 drivers/infiniband/hw/hfi1/uc.c                    |    4 +-
 drivers/infiniband/hw/hfi1/ud.c                    |    4 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.c           |    4 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h           |    4 +-
 drivers/infiniband/hw/mlx5/main.c                  |    2 +-
 drivers/infiniband/hw/mlx5/srq.c                   |   18 +-
 drivers/input/input-mt.c                           |   12 +-
 drivers/input/joystick/xpad.c                      |    2 +-
 drivers/input/keyboard/goldfish_events.c           |    9 +-
 drivers/input/misc/Kconfig                         |   10 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/sc27xx-vibra.c                  |  154 +++
 drivers/input/mouse/elan_i2c.h                     |    2 +
 drivers/input/mouse/elan_i2c_core.c                |    3 +-
 drivers/input/mouse/elan_i2c_smbus.c               |   10 +-
 drivers/input/mouse/elantech.c                     |   11 +-
 drivers/input/mouse/psmouse-base.c                 |   12 +-
 drivers/input/rmi4/Kconfig                         |    1 +
 drivers/input/rmi4/rmi_2d_sensor.c                 |   34 +-
 drivers/input/rmi4/rmi_bus.c                       |   50 +-
 drivers/input/rmi4/rmi_bus.h                       |   10 +-
 drivers/input/rmi4/rmi_driver.c                    |   52 +-
 drivers/input/rmi4/rmi_f01.c                       |   10 +-
 drivers/input/rmi4/rmi_f03.c                       |    9 +-
 drivers/input/rmi4/rmi_f11.c                       |   42 +-
 drivers/input/rmi4/rmi_f12.c                       |    8 +-
 drivers/input/rmi4/rmi_f30.c                       |    9 +-
 drivers/input/rmi4/rmi_f34.c                       |    5 +-
 drivers/input/rmi4/rmi_f54.c                       |    6 -
 drivers/input/touchscreen/silead.c                 |    1 +
 drivers/iommu/Kconfig                              |    1 -
 drivers/iommu/intel-iommu.c                        |   94 +-
 drivers/isdn/mISDN/socket.c                        |    2 +-
 drivers/md/dm-raid.c                               |    2 +-
 drivers/md/dm-table.c                              |    7 +-
 drivers/md/dm-thin-metadata.c                      |    9 -
 drivers/md/dm-thin.c                               |   11 +-
 drivers/md/dm-writecache.c                         |   53 +-
 drivers/md/dm-zoned-target.c                       |    2 +-
 drivers/md/dm.c                                    |    8 +-
 drivers/md/md.c                                    |    8 +-
 drivers/md/raid10.c                                |    7 +
 drivers/media/rc/bpf-lirc.c                        |   14 +-
 drivers/misc/cxl/api.c                             |    8 +-
 drivers/misc/ibmasm/ibmasmfs.c                     |   27 +-
 drivers/misc/mei/interrupt.c                       |    5 +-
 drivers/misc/vmw_balloon.c                         |    4 +-
 drivers/mmc/core/slot-gpio.c                       |    2 +-
 drivers/mmc/host/dw_mmc.c                          |    7 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   15 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   21 +-
 drivers/mmc/host/sunxi-mmc.c                       |    7 +
 drivers/mtd/chips/cfi_cmdset_0002.c                |   19 +-
 drivers/mtd/devices/mtd_dataflash.c                |    4 +-
 drivers/mtd/nand/raw/denali_dt.c                   |    6 +-
 drivers/mtd/nand/raw/mxc_nand.c                    |    5 +-
 drivers/mtd/nand/raw/nand_base.c                   |    2 +-
 drivers/mtd/nand/raw/nand_macronix.c               |   48 +-
 drivers/mtd/nand/raw/nand_micron.c                 |    2 +
 drivers/mtd/spi-nor/cadence-quadspi.c              |    6 +-
 drivers/net/ethernet/amd/Kconfig                   |    2 +-
 drivers/net/ethernet/apm/xgene-v2/Kconfig          |    1 -
 drivers/net/ethernet/apm/xgene/Kconfig             |    1 -
 drivers/net/ethernet/aquantia/atlantic/aq_cfg.h    |    2 -
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |    4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   |   11 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   47 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h    |    2 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c  |    2 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |    4 +-
 drivers/net/ethernet/arc/Kconfig                   |    6 +-
 drivers/net/ethernet/atheros/alx/main.c            |    8 +-
 drivers/net/ethernet/broadcom/Kconfig              |    2 -
 drivers/net/ethernet/broadcom/bcmsysport.c         |    4 +-
 drivers/net/ethernet/broadcom/bcmsysport.h         |    3 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |    1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |    6 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   24 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |   30 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |    2 -
 drivers/net/ethernet/broadcom/cnic.c               |    2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   13 +
 drivers/net/ethernet/broadcom/tg3.h                |    2 +
 drivers/net/ethernet/cadence/macb.h                |   11 +
 drivers/net/ethernet/cadence/macb_main.c           |   38 +-
 drivers/net/ethernet/cadence/macb_ptp.c            |    5 +-
 drivers/net/ethernet/calxeda/Kconfig               |    2 +-
 drivers/net/ethernet/cavium/Kconfig                |   12 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |    5 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |   14 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |    2 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |   35 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   15 +-
 drivers/net/ethernet/freescale/fman/fman_port.c    |    8 +
 drivers/net/ethernet/hisilicon/Kconfig             |    2 +-
 drivers/net/ethernet/huawei/hinic/hinic_rx.c       |    1 +
 drivers/net/ethernet/ibm/ibmvnic.c                 |   43 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   24 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   24 +-
 drivers/net/ethernet/marvell/Kconfig               |    8 +-
 drivers/net/ethernet/marvell/mvneta.c              |    2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   12 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c |    9 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |    7 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |    2 -
 drivers/net/ethernet/mellanox/mlxsw/Kconfig        |    2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |   48 +-
 drivers/net/ethernet/mscc/ocelot.c                 |   11 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c      |    9 +-
 drivers/net/ethernet/netronome/nfp/flower/match.c  |   14 +
 .../net/ethernet/netronome/nfp/flower/offload.c    |   11 +
 drivers/net/ethernet/netronome/nfp/nfp_main.c      |    6 +-
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nffw.c  |    2 +-
 drivers/net/ethernet/qlogic/qed/qed.h              |    1 +
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c         |    8 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c        |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |   10 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |   39 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |   19 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c        |   10 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  |    2 +
 drivers/net/ethernet/qualcomm/qca_spi.c            |   21 +-
 drivers/net/ethernet/realtek/r8169.c               |    3 +-
 drivers/net/ethernet/renesas/Kconfig               |    2 -
 drivers/net/ethernet/renesas/ravb_main.c           |   93 +-
 drivers/net/ethernet/renesas/sh_eth.c              |   94 +-
 drivers/net/ethernet/sfc/ef10.c                    |   30 +-
 drivers/net/ethernet/sfc/efx.c                     |   18 +-
 drivers/net/ethernet/sfc/farch.c                   |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |   12 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |    2 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |    3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    1 -
 drivers/net/ethernet/ti/davinci_cpdma.c            |    2 +-
 drivers/net/ethernet/ti/davinci_emac.c             |    4 +
 drivers/net/geneve.c                               |    2 +-
 drivers/net/hyperv/hyperv_net.h                    |    2 +-
 drivers/net/hyperv/netvsc.c                        |   54 +-
 drivers/net/hyperv/netvsc_drv.c                    |   17 +-
 drivers/net/hyperv/rndis_filter.c                  |   62 +-
 drivers/net/ieee802154/adf7242.c                   |   34 +-
 drivers/net/ieee802154/at86rf230.c                 |   15 +-
 drivers/net/ieee802154/fakelb.c                    |    2 +-
 drivers/net/ieee802154/mcr20a.c                    |    3 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   39 +-
 drivers/net/phy/dp83tc811.c                        |    2 +-
 drivers/net/phy/marvell.c                          |   54 +-
 drivers/net/phy/phy_device.c                       |    7 +-
 drivers/net/phy/sfp-bus.c                          |   35 +-
 drivers/net/ppp/pppoe.c                            |    2 +-
 drivers/net/tun.c                                  |    2 +-
 drivers/net/usb/asix_devices.c                     |    4 +-
 drivers/net/usb/lan78xx.c                          |   42 +-
 drivers/net/usb/qmi_wwan.c                         |    2 +
 drivers/net/usb/r8152.c                            |    3 +-
 drivers/net/usb/rtl8150.c                          |    2 +-
 drivers/net/usb/smsc75xx.c                         |   62 ++
 drivers/net/virtio_net.c                           |   30 +-
 drivers/net/vxlan.c                                |    4 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   16 +-
 drivers/net/wireless/ath/ath10k/wmi.h              |    1 +
 drivers/net/wireless/ath/wcn36xx/testmode.c        |    2 +-
 drivers/net/wireless/broadcom/brcm80211/Kconfig    |    1 -
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    7 +
 drivers/net/wireless/marvell/mwifiex/usb.c         |    7 +-
 drivers/net/wireless/mediatek/mt7601u/phy.c        |    6 +-
 drivers/net/wireless/quantenna/qtnfmac/Kconfig     |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    3 +-
 drivers/net/wireless/realtek/rtlwifi/base.c        |   17 +-
 drivers/net/wireless/realtek/rtlwifi/base.h        |    2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |    3 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |    2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c          |    4 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |    2 +-
 drivers/net/xen-netfront.c                         |   11 +-
 drivers/nfc/pn533/usb.c                            |    4 +-
 drivers/nvdimm/claim.c                             |    1 +
 drivers/nvdimm/pmem.c                              |    3 +-
 drivers/nvme/host/core.c                           |   63 +-
 drivers/nvme/host/pci.c                            |   12 +-
 drivers/nvme/host/rdma.c                           |    7 +-
 drivers/nvmem/core.c                               |    4 +
 drivers/of/base.c                                  |    6 +-
 drivers/of/of_private.h                            |    2 +
 drivers/of/overlay.c                               |   11 +
 drivers/pci/Makefile                               |    6 +-
 drivers/pci/controller/Kconfig                     |    3 -
 drivers/pci/controller/dwc/Kconfig                 |    1 -
 drivers/pci/controller/dwc/pcie-designware-host.c  |    3 +-
 drivers/pci/controller/pci-aardvark.c              |    2 +-
 drivers/pci/controller/pci-ftpci100.c              |    4 +-
 drivers/pci/controller/pci-hyperv.c                |    8 +-
 drivers/pci/controller/pci-v3-semi.c               |    2 +-
 drivers/pci/controller/pci-versatile.c             |    2 +-
 drivers/pci/controller/pci-xgene.c                 |    2 +-
 drivers/pci/controller/pcie-mediatek.c             |    2 +-
 drivers/pci/controller/pcie-rcar.c                 |   16 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |    2 +-
 drivers/pci/controller/pcie-xilinx.c               |    1 +
 drivers/pci/endpoint/pci-epf-core.c                |   62 +-
 drivers/pci/hotplug/acpi_pcihp.c                   |   10 +-
 drivers/pci/iov.c                                  |   16 +
 drivers/pci/of.c                                   |    2 +-
 drivers/pci/pci-acpi.c                             |   12 +
 drivers/pci/pci-driver.c                           |    1 +
 drivers/pci/pci.c                                  |   38 +
 drivers/pci/pci.h                                  |    4 +
 drivers/perf/xgene_pmu.c                           |    2 +-
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c              |    6 +-
 drivers/pinctrl/mediatek/pinctrl-mt7622.c          |   48 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c              |   14 +-
 drivers/platform/x86/dell-laptop.c                 |    2 +-
 drivers/ptp/ptp_chardev.c                          |    1 +
 drivers/rtc/interface.c                            |    8 +-
 drivers/rtc/rtc-mrst.c                             |    4 +-
 drivers/s390/block/dasd.c                          |   13 +-
 drivers/s390/block/dasd_int.h                      |    8 -
 drivers/s390/net/qeth_core.h                       |   13 +-
 drivers/s390/net/qeth_core_main.c                  |   47 +-
 drivers/s390/net/qeth_l2_main.c                    |   24 +-
 drivers/s390/net/qeth_l3_main.c                    |    3 +-
 drivers/scsi/aacraid/aachba.c                      |   15 +-
 drivers/scsi/cxlflash/main.h                       |    4 +-
 drivers/scsi/cxlflash/ocxl_hw.c                    |    5 +-
 drivers/scsi/hpsa.c                                |   25 +-
 drivers/scsi/hpsa.h                                |    1 +
 drivers/scsi/ipr.c                                 |    2 -
 drivers/scsi/qedf/qedf_main.c                      |   12 +
 drivers/scsi/qedi/qedi_main.c                      |   11 +
 drivers/scsi/qla2xxx/qla_def.h                     |    2 +
 drivers/scsi/qla2xxx/qla_gs.c                      |   40 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   14 +-
 drivers/scsi/qla2xxx/qla_os.c                      |    4 +-
 drivers/scsi/qla2xxx/qla_target.c                  |    7 +-
 drivers/scsi/scsi_debug.c                          |    2 +-
 drivers/scsi/sd_zbc.c                              |    5 +-
 drivers/scsi/sg.c                                  |   42 +-
 drivers/soc/imx/gpc.c                              |   21 +
 drivers/soc/imx/gpcv2.c                            |   13 +-
 drivers/soc/qcom/Kconfig                           |    3 +-
 drivers/soc/renesas/rcar-sysc.c                    |   35 +-
 drivers/staging/android/ion/ion_heap.c             |    2 +-
 drivers/staging/comedi/drivers/quatech_daqp_cs.c   |    2 +-
 drivers/staging/rtl8723bs/core/rtw_ap.c            |    2 +-
 drivers/staging/rtlwifi/rtl8822be/hw.c             |    2 +-
 drivers/staging/rtlwifi/wifi.h                     |    1 +
 drivers/staging/typec/Kconfig                      |    1 +
 drivers/target/target_core_pr.c                    |   15 +-
 drivers/target/target_core_user.c                  |   44 +-
 drivers/thunderbolt/domain.c                       |    4 +
 drivers/tty/n_tty.c                                |   55 +-
 drivers/tty/serdev/core.c                          |    1 +
 drivers/tty/serial/8250/8250_pci.c                 |    2 -
 drivers/tty/vt/vt.c                                |    4 +-
 drivers/uio/uio.c                                  |  139 ++-
 drivers/usb/chipidea/host.c                        |    5 +-
 drivers/usb/class/cdc-acm.c                        |    3 +
 drivers/usb/core/quirks.c                          |    4 +
 drivers/usb/dwc2/core.h                            |    3 +
 drivers/usb/dwc2/gadget.c                          |   20 +-
 drivers/usb/dwc2/hcd.c                             |   93 +-
 drivers/usb/dwc2/hcd.h                             |    8 +
 drivers/usb/dwc2/hcd_intr.c                        |   11 +-
 drivers/usb/dwc2/hcd_queue.c                       |    5 +-
 drivers/usb/dwc3/core.c                            |   23 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |    3 +-
 drivers/usb/dwc3/dwc3-pci.c                        |    2 +
 drivers/usb/dwc3/dwc3-qcom.c                       |   13 +-
 drivers/usb/gadget/composite.c                     |    3 +
 drivers/usb/gadget/function/f_fs.c                 |   26 +-
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig         |    1 +
 drivers/usb/host/xhci-dbgcap.c                     |   12 +-
 drivers/usb/host/xhci-mem.c                        |    6 +-
 drivers/usb/host/xhci-tegra.c                      |    6 +-
 drivers/usb/host/xhci-trace.h                      |   36 +-
 drivers/usb/host/xhci.c                            |   47 +-
 drivers/usb/host/xhci.h                            |    4 +
 drivers/usb/misc/yurex.c                           |   23 +-
 drivers/usb/serial/ch341.c                         |    2 +-
 drivers/usb/serial/cp210x.c                        |   15 +
 drivers/usb/serial/keyspan_pda.c                   |    4 +-
 drivers/usb/serial/mos7840.c                       |    3 +
 drivers/usb/typec/tcpm.c                           |   15 +-
 drivers/usb/typec/ucsi/ucsi.c                      |   13 +
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |    5 +
 drivers/vfio/pci/Kconfig                           |   12 +-
 drivers/vfio/pci/vfio_pci.c                        |    4 +
 drivers/vfio/vfio_iommu_spapr_tce.c                |   10 +-
 drivers/vfio/vfio_iommu_type1.c                    |   16 +-
 drivers/vhost/net.c                                |    3 +-
 fs/aio.c                                           |  153 +--
 fs/autofs/Makefile                                 |    4 +-
 fs/autofs/dev-ioctl.c                              |   22 +-
 fs/autofs/init.c                                   |    2 +-
 fs/binfmt_elf.c                                    |    5 +-
 fs/btrfs/extent_io.c                               |   12 +-
 fs/btrfs/inode.c                                   |    7 +-
 fs/btrfs/ioctl.c                                   |   12 +-
 fs/btrfs/qgroup.c                                  |   17 +-
 fs/btrfs/scrub.c                                   |   17 +-
 fs/btrfs/volumes.c                                 |    2 +
 fs/ceph/inode.c                                    |    1 +
 fs/cifs/cifsglob.h                                 |    3 +-
 fs/cifs/cifsproto.h                                |    1 +
 fs/cifs/cifssmb.c                                  |   10 +-
 fs/cifs/connect.c                                  |    8 +-
 fs/cifs/smb1ops.c                                  |    1 +
 fs/cifs/smb2file.c                                 |   11 +-
 fs/cifs/smb2ops.c                                  |   14 +-
 fs/cifs/smb2pdu.c                                  |   32 +-
 fs/cifs/smb2pdu.h                                  |    6 +-
 fs/cifs/smb2proto.h                                |    4 +-
 fs/cifs/smb2transport.c                            |   60 +-
 fs/cifs/smbdirect.c                                |    5 +-
 fs/cifs/smbdirect.h                                |    4 +-
 fs/cifs/transport.c                                |   27 +-
 fs/eventfd.c                                       |   19 +-
 fs/eventpoll.c                                     |   15 +-
 fs/exec.c                                          |    6 +-
 fs/ext4/balloc.c                                   |   21 +-
 fs/ext4/ext4.h                                     |    9 +-
 fs/ext4/ext4_extents.h                             |    1 +
 fs/ext4/extents.c                                  |    6 +
 fs/ext4/ialloc.c                                   |   14 +-
 fs/ext4/inline.c                                   |   39 +-
 fs/ext4/inode.c                                    |    7 +-
 fs/ext4/mballoc.c                                  |    6 +-
 fs/ext4/super.c                                    |   99 +-
 fs/ext4/xattr.c                                    |   40 +-
 fs/fat/inode.c                                     |   20 +-
 fs/inode.c                                         |    6 +
 fs/internal.h                                      |    1 -
 fs/jbd2/transaction.c                              |    9 +-
 fs/pipe.c                                          |   22 +-
 fs/proc/generic.c                                  |   11 +-
 fs/proc/task_mmu.c                                 |    3 +-
 fs/reiserfs/prints.c                               |  141 ++-
 fs/select.c                                        |   23 -
 fs/timerfd.c                                       |   22 +-
 fs/userfaultfd.c                                   |   12 +-
 fs/xfs/libxfs/xfs_ag_resv.c                        |   31 +-
 fs/xfs/libxfs/xfs_bmap.c                           |   26 +
 fs/xfs/libxfs/xfs_bmap.h                           |    2 +
 fs/xfs/libxfs/xfs_format.h                         |    5 +
 fs/xfs/libxfs/xfs_inode_buf.c                      |   76 +-
 fs/xfs/libxfs/xfs_rtbitmap.c                       |    4 +-
 fs/xfs/xfs_bmap_util.c                             |  106 +-
 fs/xfs/xfs_fsmap.c                                 |    4 +-
 fs/xfs/xfs_fsops.c                                 |    2 +-
 fs/xfs/xfs_inode.c                                 |   57 +-
 fs/xfs/xfs_iomap.c                                 |   15 +-
 fs/xfs/xfs_trans.c                                 |    7 +-
 include/asm-generic/tlb.h                          |    8 +
 include/crypto/if_alg.h                            |    3 +-
 include/dt-bindings/clock/imx6ul-clock.h           |   40 +-
 include/linux/acpi.h                               |    3 +
 include/linux/blkdev.h                             |    4 +-
 include/linux/bpf-cgroup.h                         |   27 +
 include/linux/bpf.h                                |    8 +
 include/linux/bpf_lirc.h                           |    5 +-
 include/linux/compat.h                             |    8 +-
 include/linux/compiler-gcc.h                       |   54 +-
 include/linux/compiler_types.h                     |   18 +
 include/linux/dax.h                                |    2 +-
 include/linux/filter.h                             |   64 +-
 include/linux/fs.h                                 |    3 +-
 include/linux/fsl/guts.h                           |    1 +
 include/linux/ftrace.h                             |    2 -
 include/linux/hid.h                                |    3 +-
 include/linux/if_bridge.h                          |    4 +-
 include/linux/igmp.h                               |    2 +
 include/linux/iio/buffer-dma.h                     |    2 +-
 include/linux/input/mt.h                           |    2 +-
 include/linux/intel-iommu.h                        |    1 +
 include/linux/kthread.h                            |    1 -
 include/linux/kvm_host.h                           |   24 +-
 include/linux/libata.h                             |   24 +
 include/linux/marvell_phy.h                        |    2 +
 include/linux/mlx5/eswitch.h                       |    2 +
 include/linux/mlx5/mlx5_ifc.h                      |    2 +-
 include/linux/mm.h                                 |    6 +-
 include/linux/net.h                                |    1 -
 include/linux/netdevice.h                          |   20 +
 include/linux/pci.h                                |    2 +
 include/linux/pm_domain.h                          |    6 +-
 include/linux/poll.h                               |   12 +-
 include/linux/rmi.h                                |    2 +
 include/linux/scatterlist.h                        |   18 -
 include/linux/sched.h                              |    2 +-
 include/linux/sched/task.h                         |    2 +-
 include/linux/skbuff.h                             |   13 +-
 include/linux/slub_def.h                           |    4 +
 include/linux/syscalls.h                           |    5 +
 include/linux/uio_driver.h                         |    2 +-
 include/net/bluetooth/bluetooth.h                  |    2 +-
 include/net/ip6_route.h                            |    6 +
 include/net/ipv6.h                                 |   13 +-
 include/net/iucv/af_iucv.h                         |    2 +
 include/net/net_namespace.h                        |    1 +
 include/net/netfilter/nf_tables_core.h             |    6 +
 include/net/netfilter/nf_tproxy.h                  |    4 +-
 include/net/netns/ipv6.h                           |    1 -
 include/net/pkt_cls.h                              |    5 +
 include/net/sctp/sctp.h                            |    3 +-
 include/net/tc_act/tc_csum.h                       |    1 -
 include/net/tc_act/tc_tunnel_key.h                 |    1 -
 include/net/tcp.h                                  |    9 +-
 include/net/tls.h                                  |    6 +-
 include/net/udp.h                                  |    2 +-
 include/net/xdp_sock.h                             |    4 +
 include/uapi/linux/aio_abi.h                       |   12 +-
 include/uapi/linux/bpf.h                           |   28 +-
 include/uapi/linux/ethtool.h                       |    2 +-
 include/uapi/linux/kvm.h                           |    4 +
 include/uapi/linux/kvm_para.h                      |    2 +
 include/uapi/linux/rseq.h                          |  102 +-
 include/uapi/linux/target_core_user.h              |    4 +-
 include/uapi/linux/tcp.h                           |    4 +
 include/uapi/linux/types_32_64.h                   |   50 -
 init/Kconfig                                       |    7 +-
 kernel/bpf/btf.c                                   |   30 +-
 kernel/bpf/cgroup.c                                |   54 +
 kernel/bpf/core.c                                  |   30 +-
 kernel/bpf/devmap.c                                |    7 +-
 kernel/bpf/hashtab.c                               |   16 +-
 kernel/bpf/sockmap.c                               |  297 +++--
 kernel/bpf/syscall.c                               |  103 +-
 kernel/bpf/verifier.c                              |   11 +-
 kernel/dma/swiotlb.c                               |    1 +
 kernel/events/core.c                               |    2 +-
 kernel/fork.c                                      |   35 +-
 kernel/kthread.c                                   |   30 +-
 kernel/rseq.c                                      |   41 +-
 kernel/sched/core.c                                |   67 +-
 kernel/sched/cpufreq_schedutil.c                   |    2 +-
 kernel/sched/deadline.c                            |   11 +-
 kernel/sched/fair.c                                |   45 +-
 kernel/sched/rt.c                                  |   16 +-
 kernel/sched/sched.h                               |   11 +-
 kernel/softirq.c                                   |   12 +-
 kernel/stop_machine.c                              |    6 +-
 kernel/time/tick-common.c                          |    3 +-
 kernel/trace/ftrace.c                              |   13 +-
 kernel/trace/trace.c                               |   13 +-
 kernel/trace/trace.h                               |    4 +-
 kernel/trace/trace_events_filter.c                 |    5 +
 kernel/trace/trace_events_hist.c                   |    2 +-
 kernel/trace/trace_functions_graph.c               |    5 +-
 kernel/trace/trace_kprobe.c                        |    6 +-
 kernel/trace/trace_output.c                        |    5 +-
 lib/Kconfig.kasan                                  |    1 +
 lib/iov_iter.c                                     |   77 +-
 lib/percpu_ida.c                                   |    2 +-
 lib/rhashtable.c                                   |   27 +-
 lib/scatterlist.c                                  |    6 -
 lib/test_bpf.c                                     |   20 +
 lib/test_printf.c                                  |    7 -
 mm/debug.c                                         |   18 +-
 mm/gup.c                                           |    2 -
 mm/huge_memory.c                                   |    2 +
 mm/hugetlb.c                                       |    1 +
 mm/kasan/kasan.c                                   |    5 +-
 mm/memblock.c                                      |    6 +-
 mm/memcontrol.c                                    |    2 +-
 mm/mmap.c                                          |   64 +-
 mm/nommu.c                                         |   10 +-
 mm/page_alloc.c                                    |    8 +-
 mm/rmap.c                                          |    8 +-
 mm/slab_common.c                                   |    4 +
 mm/slub.c                                          |    7 +-
 mm/vmstat.c                                        |    2 -
 net/8021q/vlan.c                                   |    2 +-
 net/9p/client.c                                    |    3 +-
 net/Makefile                                       |    4 -
 net/appletalk/ddp.c                                |    2 +-
 net/atm/common.c                                   |   11 +-
 net/atm/common.h                                   |    2 +-
 net/atm/pvc.c                                      |    2 +-
 net/atm/svc.c                                      |    2 +-
 net/ax25/af_ax25.c                                 |    2 +-
 net/batman-adv/bat_iv_ogm.c                        |    4 +-
 net/batman-adv/bat_v.c                             |    4 +-
 net/batman-adv/debugfs.c                           |   40 +
 net/batman-adv/debugfs.h                           |   11 +
 net/batman-adv/hard-interface.c                    |   37 +-
 net/batman-adv/translation-table.c                 |    7 +-
 net/bluetooth/af_bluetooth.c                       |    7 +-
 net/bluetooth/hci_sock.c                           |    2 +-
 net/bluetooth/l2cap_sock.c                         |    2 +-
 net/bluetooth/rfcomm/sock.c                        |    2 +-
 net/bluetooth/sco.c                                |    2 +-
 net/bpf/test_run.c                                 |   17 +-
 net/bpfilter/Kconfig                               |    2 +-
 net/bpfilter/Makefile                              |   17 +-
 net/bpfilter/bpfilter_kern.c                       |   11 +-
 net/bpfilter/bpfilter_umh_blob.S                   |    7 +
 net/caif/caif_socket.c                             |   12 +-
 net/can/bcm.c                                      |    2 +-
 net/can/raw.c                                      |    2 +-
 net/core/datagram.c                                |   13 +-
 net/core/dev_ioctl.c                               |   11 +-
 net/core/fib_rules.c                               |   80 +-
 net/core/filter.c                                  |  235 +++-
 net/core/gen_stats.c                               |   16 +-
 net/core/skbuff.c                                  |    4 +-
 net/core/sock.c                                    |    7 +-
 net/dccp/ccids/ccid3.c                             |   16 +-
 net/dccp/dccp.h                                    |    3 +-
 net/dccp/ipv4.c                                    |    2 +-
 net/dccp/ipv6.c                                    |    2 +-
 net/dccp/proto.c                                   |   13 +-
 net/decnet/af_decnet.c                             |    6 +-
 net/dns_resolver/dns_key.c                         |   28 +-
 net/ieee802154/6lowpan/core.c                      |    6 +
 net/ieee802154/socket.c                            |    4 +-
 net/ipv4/af_inet.c                                 |    8 +-
 net/ipv4/fib_frontend.c                            |    1 +
 net/ipv4/fou.c                                     |    4 +-
 net/ipv4/gre_offload.c                             |    2 +-
 net/ipv4/igmp.c                                    |   58 +-
 net/ipv4/inet_fragment.c                           |    2 +-
 net/ipv4/ip_sockglue.c                             |    4 +-
 net/ipv4/netfilter/ip_tables.c                     |    1 +
 net/ipv4/netfilter/nf_tproxy_ipv4.c                |   18 +-
 net/ipv4/sysctl_net_ipv4.c                         |   23 +-
 net/ipv4/tcp.c                                     |   39 +-
 net/ipv4/tcp_dctcp.c                               |   31 +-
 net/ipv4/tcp_input.c                               |   13 +-
 net/ipv4/tcp_ipv4.c                                |   23 +-
 net/ipv4/tcp_output.c                              |    4 -
 net/ipv4/udp.c                                     |   10 +-
 net/ipv4/udp_offload.c                             |    2 +-
 net/ipv6/Kconfig                                   |    1 +
 net/ipv6/addrconf.c                                |    9 +-
 net/ipv6/af_inet6.c                                |    4 +-
 net/ipv6/calipso.c                                 |    9 +-
 net/ipv6/exthdrs.c                                 |  111 +-
 net/ipv6/ip6_fib.c                                 |  156 +--
 net/ipv6/ip6_gre.c                                 |    3 +-
 net/ipv6/ipv6_sockglue.c                           |   32 +-
 net/ipv6/mcast.c                                   |   73 +-
 net/ipv6/ndisc.c                                   |    2 +-
 net/ipv6/netfilter/ip6_tables.c                    |    1 +
 net/ipv6/netfilter/nf_conntrack_reasm.c            |    8 +-
 net/ipv6/netfilter/nf_tproxy_ipv6.c                |   18 +-
 net/ipv6/raw.c                                     |    4 +-
 net/ipv6/route.c                                   |   10 +-
 net/ipv6/seg6_hmac.c                               |    2 +-
 net/ipv6/seg6_iptunnel.c                           |    2 +-
 net/iucv/af_iucv.c                                 |    7 +-
 net/kcm/kcmsock.c                                  |   10 +-
 net/key/af_key.c                                   |    2 +-
 net/l2tp/l2tp_ip.c                                 |    2 +-
 net/l2tp/l2tp_ip6.c                                |    2 +-
 net/l2tp/l2tp_ppp.c                                |    2 +-
 net/llc/af_llc.c                                   |    2 +-
 net/mac80211/tx.c                                  |    2 +
 net/netfilter/Kconfig                              |   25 +-
 net/netfilter/Makefile                             |    7 +-
 net/netfilter/nf_conncount.c                       |   52 +-
 net/netfilter/nf_conntrack_core.c                  |    2 +-
 net/netfilter/nf_conntrack_helper.c                |    5 +
 net/netfilter/nf_log.c                             |   13 +-
 net/netfilter/nf_tables_set_core.c                 |   28 +
 net/netfilter/nfnetlink_queue.c                    |    3 +
 net/netfilter/nft_compat.c                         |   13 +
 net/netfilter/nft_set_bitmap.c                     |   19 +-
 net/netfilter/nft_set_hash.c                       |   29 +-
 net/netfilter/nft_set_rbtree.c                     |   19 +-
 net/netfilter/xt_TPROXY.c                          |    8 +-
 net/netlink/af_netlink.c                           |    2 +-
 net/netrom/af_netrom.c                             |    2 +-
 net/nfc/llcp_commands.c                            |    9 +-
 net/nfc/llcp_sock.c                                |    9 +-
 net/nfc/rawsock.c                                  |    4 +-
 net/nsh/nsh.c                                      |    2 +-
 net/packet/af_packet.c                             |   27 +-
 net/phonet/socket.c                                |    9 +-
 net/qrtr/qrtr.c                                    |   15 +-
 net/rds/connection.c                               |   11 +-
 net/rds/loop.c                                     |   56 +
 net/rds/loop.h                                     |    2 +
 net/rose/af_rose.c                                 |    2 +-
 net/rxrpc/af_rxrpc.c                               |   10 +-
 net/sched/act_csum.c                               |    6 +-
 net/sched/act_tunnel_key.c                         |    6 +-
 net/sched/cls_api.c                                |    4 +-
 net/sched/cls_flower.c                             |   21 +-
 net/sched/sch_fq_codel.c                           |   25 +-
 net/sched/sch_hfsc.c                               |    4 +-
 net/sctp/chunk.c                                   |    4 +-
 net/sctp/ipv6.c                                    |    2 +-
 net/sctp/protocol.c                                |    2 +-
 net/sctp/socket.c                                  |    4 +-
 net/sctp/transport.c                               |    2 +-
 net/smc/af_smc.c                                   |  138 ++-
 net/smc/smc.h                                      |    8 +
 net/smc/smc_clc.c                                  |    3 +-
 net/smc/smc_close.c                                |    2 +
 net/smc/smc_tx.c                                   |   12 +-
 net/socket.c                                       |   50 +-
 net/strparser/strparser.c                          |   22 +-
 net/tipc/discover.c                                |   18 +-
 net/tipc/net.c                                     |   17 +-
 net/tipc/node.c                                    |    7 +-
 net/tipc/socket.c                                  |   14 +-
 net/tls/tls_main.c                                 |    2 +-
 net/tls/tls_sw.c                                   |   26 +-
 net/unix/af_unix.c                                 |   30 +-
 net/vmw_vsock/af_vsock.c                           |   19 +-
 net/vmw_vsock/virtio_transport.c                   |    2 +-
 net/wireless/nl80211.c                             |   35 +-
 net/x25/af_x25.c                                   |    2 +-
 net/xdp/xsk.c                                      |   37 +-
 net/xdp/xsk_queue.h                                |    9 +-
 samples/bpf/.gitignore                             |   49 +
 samples/bpf/parse_varlen.c                         |    6 +-
 samples/bpf/test_overhead_user.c                   |   19 +-
 samples/bpf/trace_event_user.c                     |   27 +-
 samples/bpf/xdp2skb_meta.sh                        |    6 +-
 samples/bpf/xdp_fwd_kern.c                         |    8 +-
 samples/bpf/xdpsock_user.c                         |    2 +-
 samples/vfio-mdev/mbochs.c                         |   23 +-
 scripts/Kbuild.include                             |    2 +-
 scripts/Makefile.build                             |    3 -
 scripts/Makefile.clean                             |    3 -
 scripts/Makefile.modbuiltin                        |    4 -
 scripts/Makefile.modinst                           |    4 -
 scripts/Makefile.modpost                           |    4 -
 scripts/Makefile.modsign                           |    3 -
 scripts/cc-can-link.sh                             |    2 +-
 scripts/checkpatch.pl                              |   12 +-
 scripts/extract-vmlinux                            |    2 +
 scripts/gcc-x86_64-has-stack-protector.sh          |    2 +-
 scripts/kconfig/expr.h                             |    3 +
 scripts/kconfig/preprocess.c                       |    2 +-
 scripts/kconfig/zconf.y                            |    8 +-
 scripts/tags.sh                                    |    3 +-
 security/keys/dh.c                                 |    6 +-
 security/selinux/selinuxfs.c                       |   78 +-
 security/smack/smack_lsm.c                         |    1 +
 sound/core/rawmidi.c                               |   20 +-
 sound/core/seq/seq_clientmgr.c                     |    3 +-
 sound/core/timer.c                                 |    2 +-
 sound/pci/hda/hda_codec.c                          |    5 +-
 sound/pci/hda/hda_codec.h                          |    1 +
 sound/pci/hda/patch_ca0132.c                       |   67 +-
 sound/pci/hda/patch_conexant.c                     |    1 +
 sound/pci/hda/patch_hdmi.c                         |   24 +-
 sound/pci/hda/patch_realtek.c                      |   26 +-
 sound/pci/lx6464es/lx6464es.c                      |    1 +
 tools/arch/arm/include/uapi/asm/kvm.h              |    1 +
 tools/arch/arm64/include/uapi/asm/kvm.h            |    1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h          |    1 +
 tools/arch/powerpc/include/uapi/asm/unistd.h       |    1 +
 tools/arch/x86/include/asm/cpufeatures.h           |    2 +
 tools/bpf/bpftool/prog.c                           |   12 +-
 tools/build/Build.include                          |    6 +-
 tools/build/Makefile                               |    2 +-
 tools/include/uapi/drm/drm.h                       |    7 +
 tools/include/uapi/linux/bpf.h                     |    2 +-
 tools/include/uapi/linux/if_link.h                 |    2 +
 tools/include/uapi/linux/kvm.h                     |    1 +
 tools/objtool/elf.c                                |   47 +-
 tools/perf/Makefile.config                         |    3 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |    2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    2 +
 tools/perf/arch/x86/util/perf_regs.c               |    2 +-
 tools/perf/bench/numa.c                            |    5 +-
 tools/perf/builtin-annotate.c                      |   11 +-
 tools/perf/builtin-report.c                        |    3 +-
 tools/perf/builtin-script.c                        |   30 +-
 tools/perf/builtin-stat.c                          |    2 +-
 tools/perf/jvmti/jvmti_agent.c                     |    3 +-
 tools/perf/pmu-events/Build                        |    2 +-
 .../python/Perf-Trace-Util/lib/Perf/Trace/Core.py  |   40 +-
 .../Perf-Trace-Util/lib/Perf/Trace/EventClass.py   |    4 +-
 .../Perf-Trace-Util/lib/Perf/Trace/SchedGui.py     |    2 +-
 .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py  |   11 +-
 tools/perf/scripts/python/sched-migration.py       |   14 +-
 tools/perf/tests/builtin-test.c                    |    2 +-
 tools/perf/tests/parse-events.c                    |   25 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |   37 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    2 +-
 tools/perf/tests/topology.c                        |    1 +
 tools/perf/util/c++/clang.cpp                      |   11 +-
 tools/perf/util/header.c                           |   12 +-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |    2 +-
 tools/perf/util/llvm-utils.c                       |    6 +-
 tools/perf/util/pmu.c                              |   99 +-
 .../util/scripting-engines/trace-event-python.c    |   37 +-
 tools/testing/nvdimm/test/nfit.c                   |    3 +-
 tools/testing/selftests/bpf/config                 |    1 +
 tools/testing/selftests/bpf/test_kmod.sh           |    9 +
 tools/testing/selftests/bpf/test_lirc_mode2.sh     |    9 +
 tools/testing/selftests/bpf/test_lwt_seg6local.sh  |    9 +
 tools/testing/selftests/bpf/test_sockmap.c         |    6 -
 tools/testing/selftests/bpf/test_verifier.c        |   23 +-
 tools/testing/selftests/kvm/.gitignore             |    2 +
 tools/testing/selftests/kvm/Makefile               |    2 +
 tools/testing/selftests/kvm/cr4_cpuid_sync_test.c  |  129 +++
 tools/testing/selftests/kvm/include/kvm_util.h     |    4 +-
 tools/testing/selftests/kvm/include/vmx.h          |   66 +-
 tools/testing/selftests/kvm/include/x86.h          |    8 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |   94 +-
 .../testing/selftests/kvm/lib/kvm_util_internal.h  |    7 +-
 tools/testing/selftests/kvm/lib/vmx.c              |  104 +-
 tools/testing/selftests/kvm/lib/x86.c              |  256 ++++-
 tools/testing/selftests/kvm/state_test.c           |  218 ++++
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c  |   69 +-
 tools/testing/selftests/net/.gitignore             |    1 +
 tools/testing/selftests/net/config                 |    2 +
 tools/testing/selftests/net/fib_tests.sh           |   41 -
 tools/testing/selftests/net/udpgso_bench.sh        |    3 -
 tools/testing/selftests/rseq/rseq.h                |   24 +-
 tools/testing/selftests/x86/sigreturn.c            |   59 +-
 tools/virtio/linux/scatterlist.h                   |   18 -
 virt/kvm/eventfd.c                                 |   17 +-
 virt/kvm/kvm_main.c                                |   33 +-
 1145 files changed, 12731 insertions(+), 6392 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
 delete mode 100644 arch/microblaze/kernel/heartbeat.c
 delete mode 100644 arch/microblaze/kernel/platform.c
 create mode 100644 arch/x86/hyperv/nested.c
 create mode 100644 arch/x86/kernel/irqflags.S
 create mode 100644 drivers/input/misc/sc27xx-vibra.c
 delete mode 100644 include/uapi/linux/types_32_64.h
 create mode 100644 net/bpfilter/bpfilter_umh_blob.S
 create mode 100644 net/netfilter/nf_tables_set_core.c
 create mode 100644 samples/bpf/.gitignore
 create mode 100644 tools/testing/selftests/kvm/cr4_cpuid_sync_test.c
 create mode 100644 tools/testing/selftests/kvm/state_test.c
 mode change 100644 => 100755 tools/testing/selftests/net/fib_tests.sh
```
