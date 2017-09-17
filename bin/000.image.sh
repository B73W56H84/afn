#!/bin/bash

# `set` command has no -s command-line option.
# I just want to say sex.
set sex

# when SIGTERM this, remove temporary files.
trap "rm images/temp/*png" 15

# if your macOS has no 'sips' command,
# exit and know what the Answer to the Ultimate Question of Life, the Universe, and Everything.
path_to_sips=$(which sips)
if [ ! -x "$path_to_sips" ]
then
  echo ' No sips command ' >&2
  exit 42
fi

# if you haven't install 'pngquant' yet,
# exit with Chihaya's size.
path_to_pngquant=$(which pngquant)
if [ ! -x "$path_to_pngquant" ]
then
  echo ' No pngquant command ' >&2
  exit 72
fi

# 0. Remove png files.
rm images/temp/*.png

# 1-1. Copy png files to workspace.
cp images/*.png images/temp/

# 1-2. Convert jpg to png.
for i in images/*.jpg
do
  out=${i##*/}
  out=${out/jpg/png}

  sips -s format png $i --out images/temp/$out
done

# 2. Resize 100x100 and clobber.
for j in images/temp/*.png
do
  sips -Z 100 $j
done

# 3. Compress
## --ext .png --force : Convert files in place.
## --posterize 3      : Truncate number of least significant bits of color (per channel).
## --nofs             : Disable Floyd-Steinberg dithering.
## --speed 10         : 5% lower quality, but is about 8 times faster than the default.
## 32                 : The resulting image will have 32 colors.
pngquant --ext .png --force --posterize 3 --nofs --speed 10 32 images/temp/*.png

exit 0
