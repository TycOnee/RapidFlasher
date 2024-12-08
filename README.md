# RapidFlasher

A Hybrid ROM Installer.

Usually flashes rom in below 1 minute (RECOVERY)

update-binary supports zstd (Zstandard), gzip (pigz) and sparse compressed partition images.

***

### Available Functions ###
- ui_print "TEXT" : prints a text when flashing.
- verify_device "CODENAME1,CODENAME2,CODENAME3,ETC..." : verifies the device. if device is unsupported, then abort flashing.
- package_extract_file "FILE/PARTITION" "TARGET FILE/TARGET BLOCK DEVICE" : extracts file to a dir or flashes uncompressed partition.
- package_flash_partition "0/1/2" "FILE" "TARGET BLOCK DEVICE" : flashes compressed image into its target partition
  - 0 : zstd (Zstandard)
  - 1 : gzip (pigz)
  - 2 : sparse (sparsechunk is not supported yet)
- package_extract_targz "tar.gz file" "outdir" : extracts tar gz compressed file into a directory
  
