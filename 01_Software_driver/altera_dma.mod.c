#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0xbd078ac0, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0xf1c3c77c, __VMLINUX_SYMBOL_STR(pci_unregister_driver) },
	{ 0x7f9da064, __VMLINUX_SYMBOL_STR(__pci_register_driver) },
	{ 0xb35dea8f, __VMLINUX_SYMBOL_STR(__arch_copy_to_user) },
	{ 0x84bc974b, __VMLINUX_SYMBOL_STR(__arch_copy_from_user) },
	{ 0x9c5bc552, __VMLINUX_SYMBOL_STR(finish_wait) },
	{ 0xcb128141, __VMLINUX_SYMBOL_STR(prepare_to_wait_event) },
	{ 0x1000e51, __VMLINUX_SYMBOL_STR(schedule) },
	{ 0x622598b1, __VMLINUX_SYMBOL_STR(init_wait_entry) },
	{ 0x65345022, __VMLINUX_SYMBOL_STR(__wake_up) },
	{ 0x4f68e5c9, __VMLINUX_SYMBOL_STR(do_gettimeofday) },
	{ 0xdcb764ad, __VMLINUX_SYMBOL_STR(memset) },
	{ 0xeae3dfd6, __VMLINUX_SYMBOL_STR(__const_udelay) },
	{ 0x79aa04a2, __VMLINUX_SYMBOL_STR(get_random_bytes) },
	{ 0xdbee26c0, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x390f82db, __VMLINUX_SYMBOL_STR(dma_alloc_from_coherent_attr) },
	{ 0xab40cca9, __VMLINUX_SYMBOL_STR(__init_waitqueue_head) },
	{ 0xf24b3dfe, __VMLINUX_SYMBOL_STR(__ioremap) },
	{ 0x8953a9a, __VMLINUX_SYMBOL_STR(pci_bus_read_config_byte) },
	{ 0x30b1e80c, __VMLINUX_SYMBOL_STR(pci_enable_msi_range) },
	{ 0x351d69aa, __VMLINUX_SYMBOL_STR(pci_set_master) },
	{ 0x3059a9cb, __VMLINUX_SYMBOL_STR(pci_request_regions) },
	{ 0x2bd68d1, __VMLINUX_SYMBOL_STR(_dev_info) },
	{ 0xb7cbfa8, __VMLINUX_SYMBOL_STR(pci_enable_device) },
	{ 0x4752d2c5, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0x1a635889, __VMLINUX_SYMBOL_STR(cdev_add) },
	{ 0x78189d04, __VMLINUX_SYMBOL_STR(cdev_init) },
	{ 0x29537c9e, __VMLINUX_SYMBOL_STR(alloc_chrdev_region) },
	{ 0x347b75e7, __VMLINUX_SYMBOL_STR(kmem_cache_alloc_trace) },
	{ 0xbdecb211, __VMLINUX_SYMBOL_STR(dma_ops) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0xe1b77fe6, __VMLINUX_SYMBOL_STR(dma_release_from_coherent_attr) },
	{ 0xf20dabd8, __VMLINUX_SYMBOL_STR(free_irq) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xed6ed1ee, __VMLINUX_SYMBOL_STR(pci_release_regions) },
	{ 0xbea697e4, __VMLINUX_SYMBOL_STR(pci_disable_msi) },
	{ 0x864cac4, __VMLINUX_SYMBOL_STR(pci_disable_device) },
	{ 0x7485e15e, __VMLINUX_SYMBOL_STR(unregister_chrdev_region) },
	{ 0x8d7a0a5c, __VMLINUX_SYMBOL_STR(cdev_del) },
	{ 0x1fdc7df2, __VMLINUX_SYMBOL_STR(_mcount) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";

MODULE_ALIAS("pci:v00001172d0000E003sv*sd*bc*sc*i*");

MODULE_INFO(srcversion, "244C3FE00685FA4517A50B0");
