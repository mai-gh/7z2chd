# 7z2chd

### Convert 7z archives that contain BIN/CUE CD images into CHD archives

---

I made this to use with MiSTer FPGA, but it could be useful for other emulation set-ups.

#### Usage:

```
# pacman -S p7zip mame-tools

$ cd /place/where/7z/files/are 
$ mkdir chd
$ cd chd
$ wget https://raw.githubusercontent.com/mai-gh/7z2chd/main/7z2chd.sh
$ chmod +x 7z2chd.sh
$ ./7z2chd.sh
```

This will then find all the 7z archives in the parent directory (`../`) and one at a time do the following to each:

1. extract 7z to `/tmp`
2. use `chdman` to pack to another file in `/tmp`
3. copy the chd file to the current working directory (`/place/where/7z/files/are/chd`)
4. remove all temporary files from `/tmp`

