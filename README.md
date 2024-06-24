# RapidFlasher

Usually flashes rom in below 1 minute

Supports zstd (Zstandard) and gzip (pigz) compressed partition images.

***

### Available Functions ###
- ui_print "TEXT" : prints a text when flashing.
- verify_device "CODENAME1,CODENAME2,CODENAME3,ETC..." : verifies the device. if device is unsupported, then abort flashing.
- package_extract_file "FILE/PARTITION" "TARGET FILE/TARGET BLOCK DEVICE" : extracts file to a dir or flashes uncompressed partition.
- package_flash_partition "0/1" "FILE" "TARGET BLOCK DEVICE" : flashes compressed image into its target partition
  - 0 : zstd (Zstandard)
  - 1 : gzip (pigz)
- package_extract_oplus_partitions "oplus partitions .tar.gz file" : [for this](https://github.com/Danda420/oplus_image_flasher)
  