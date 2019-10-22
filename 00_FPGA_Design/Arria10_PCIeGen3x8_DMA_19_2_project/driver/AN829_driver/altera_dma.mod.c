#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
 .name = KBUILD_MODNAME,
 .init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
 .exit = cleanup_module,
#endif
 .arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x14522340, "module_layout" },
	{ 0x42e80c19, "cdev_del" },
	{ 0x4f1939c7, "per_cpu__current_task" },
	{ 0xc917223d, "pci_bus_read_config_byte" },
	{ 0xc45a9f63, "cdev_init" },
	{ 0xd2037915, "dev_set_drvdata" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0x79aa04a2, "get_random_bytes" },
	{ 0xd691cba2, "malloc_sizes" },
	{ 0xa30682, "pci_disable_device" },
	{ 0xd3364703, "x86_dma_fallback_dev" },
	{ 0xeae3dfd6, "__const_udelay" },
	{ 0x102b9c3, "pci_release_regions" },
	{ 0x7485e15e, "unregister_chrdev_region" },
	{ 0xffc7c184, "__init_waitqueue_head" },
	{ 0xaf559063, "pci_set_master" },
	{ 0xde0bdcff, "memset" },
	{ 0x9f1019bd, "pci_set_dma_mask" },
	{ 0x747f9a8e, "pci_iounmap" },
	{ 0x8502d858, "dev_err" },
	{ 0xea147363, "printk" },
	{ 0x85f8a266, "copy_to_user" },
	{ 0xb4390f9a, "mcount" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0xa6d1bdca, "cdev_add" },
	{ 0x9b3277f3, "_dev_info" },
	{ 0x78764f4e, "pv_irq_ops" },
	{ 0x42c8de35, "ioremap_nocache" },
	{ 0x1000e51, "schedule" },
	{ 0x68f7c535, "pci_unregister_driver" },
	{ 0x2044fa9e, "kmem_cache_alloc_trace" },
	{ 0x642e54ac, "__wake_up" },
	{ 0x1d2e87c6, "do_gettimeofday" },
	{ 0x37a0cba, "kfree" },
	{ 0x6d090f30, "pci_request_regions" },
	{ 0x33d92f9a, "prepare_to_wait" },
	{ 0x94a8242d, "pci_disable_msi" },
	{ 0x5f07b9f3, "__pci_register_driver" },
	{ 0x9ccb2622, "finish_wait" },
	{ 0x6a7a886b, "pci_enable_msi_block" },
	{ 0x436c2179, "iowrite32" },
	{ 0xa12add91, "pci_enable_device" },
	{ 0xb02504d8, "pci_set_consistent_dma_mask" },
	{ 0x3302b500, "copy_from_user" },
	{ 0xa92a43c, "dev_get_drvdata" },
	{ 0x6e9681d2, "dma_ops" },
	{ 0x29537c9e, "alloc_chrdev_region" },
	{ 0xe484e35f, "ioread32" },
	{ 0xf20dabd8, "free_irq" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";

MODULE_ALIAS("pci:v00001172d0000E003sv*sd*bc*sc*i*");

MODULE_INFO(srcversion, "F0DCB9B66172342BFB0E365");

static const struct rheldata _rheldata __used
__attribute__((section(".rheldata"))) = {
	.rhel_major = 6,
	.rhel_minor = 9,
	.rhel_release = 695,
};
