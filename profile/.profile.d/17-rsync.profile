#!/usr/bin/env bash

##############################################################################
# RSYNC
#
# List of compressed file formats for use with
# rsync --skip-compress=$RSYNC_SKIP_COMPRESS
#   https://gist.github.com/StefanHamminga/2b1734240025f5ee916a
#
# Split long string argument to multiple lines
#   https://stackoverflow.com/a/46808582/2377454

export RSYNC_SKIP_COMPRESS="\
3g2/3gp/3gpp/7z/aac/ace/amr/apk/appx/appxbundle/arc/arj/\
asf/avi/bz2/cab/crypt5/crypt7/crypt8/deb/dmg/drc/ear/gz/\
flac/flv/gpg/iso/jar/jp2/jpg/jpeg/lz/lzma/lzo/m4a/m4p/\
m4v/mkv/msi/mov/mp3/mp4/mpeg/mpg/mpv/oga/ogg/ogv/opus/\
pack/png/qt/rar/rpm/rzip/s7z/sfx/svgz/tbz/tgz/tlz/txz/\
vob/wim/wma/wmv/xz/z/zip/zst\
"
