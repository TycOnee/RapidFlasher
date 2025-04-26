# RapidFlasher

A Hybrid ROM Installer.

Usually flashes rom in below 1 minute (RECOVERY)

update-binary supports zstd (Zstandard), gzip (pigz) and sparse compressed partition images.

***

### Available Functions ###
- ui_print "TEXT" : prints a text when flashing.
- verify_device "CODENAME1,CODENAME2,CODENAME3,ETC..." : verifies the device. if device is unsupported, then abort flashing.
- package_extract_file "FILE/PARTITION" "TARGET FILE/TARGET BLOCK DEVICE" : extracts file to a dir or flashes uncompressed partition.
- package_flash_partition "0/1" "FILE" "TARGET BLOCK DEVICE" : flashes compressed image into its target partition
- package_flash_partition "2" "FILE" "TARGET BLOCK DEVICE" : if you want to flash regular sparse
- package_flash_partition "2" "NAME/PATTERN" "STARTING CHUNK" "ENDING CHUNK" "TARGET BLOCK DEVICE" : if you want to flash sparsechunk (for example.. theres a file named super.img_sparsechunk.0-12 that you want to flash, you need to put it like this: package_flash_partition "2" "super.img_sparsechunk" "0" "12" "/dev/block/bootdevice/by-name/super")
  - 0 : zstd (Zstandard)
  - 1 : gzip (pigz)
  - 2 : sparse & sparsechunk
- package_extract_targz "tar.gz file" "outdir" : extracts tar gz compressed file into a directory

***

### Note ###
sparse and sparsechunk flashing needs decrypted /data
