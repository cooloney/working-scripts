
make -j8 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- CONFIG_DEBUG_SECTION_MISMATCH=y omap4_defconfig
make -j8 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- CONFIG_DEBUG_SECTION_MISMATCH=y menuconfig
make -j8 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- CONFIG_DEBUG_SECTION_MISMATCH=y uImage

