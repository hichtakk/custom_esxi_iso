passwd:
	@mkpasswd --method=sha-512

mount:
	@mount -o loop ./VMware-VMvisor-Installer-7.*.x86_64.iso /mnt/esxi
	@cp -r /mnt/esxi ./esxi
	@umount /mnt/esxi

iso:
	@cp ks.cfg esxi/ks.cfg
	@sed -i -e "s/kernelopt=.*/kernelopt=ks=cdrom:\/KS.CFG/g" ./esxi/boot.cfg
	@sed -i -e "s/kernelopt=.*/kernelopt=ks=cdrom:\/KS.CFG/g" ./esxi/efi/boot/boot.cfg
	@mkisofs -relaxed-filenames -J -R -b isolinux.bin -c boot.cat \
		-no-emul-boot -boot-load-size 4 -boot-info-table \
		-eltorito-alt-boot -e efiboot.img -boot-load-size 1 \
		-no-emul-boot -o custom_esxi.iso ./esxi

