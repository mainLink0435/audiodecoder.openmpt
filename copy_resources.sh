#!/bin/bash
# Copy addon resources and library to build directory

BUILD_DIR="${1:-.}"
SRC_DIR="$(dirname "$0")/audiodecoder.openmpt"

mkdir -p "$BUILD_DIR/audiodecoder.openmpt"
cp "$SRC_DIR/icon.png" "$BUILD_DIR/audiodecoder.openmpt/"
cp "$SRC_DIR/fanart.jpg" "$BUILD_DIR/audiodecoder.openmpt/"
cp -r "$SRC_DIR/resources" "$BUILD_DIR/audiodecoder.openmpt/"

# Copy the compiled .so library
cp "$BUILD_DIR/audiodecoder.openmpt.so.21.99.1" "$BUILD_DIR/audiodecoder.openmpt/"

# Copy dependency libraries that aren't statically linked
# Find the libmpg123.so.0 in standard library paths
LIBMPG123=$(find /usr/lib -name "libmpg123.so.0" 2>/dev/null | head -1)
if [ -n "$LIBMPG123" ]; then
    cp "$LIBMPG123" "$BUILD_DIR/audiodecoder.openmpt/"
    
    # Use patchelf to set RPATH so the .so can find libmpg123 in its own directory
    if command -v patchelf &> /dev/null; then
        patchelf --set-rpath '$ORIGIN' "$BUILD_DIR/audiodecoder.openmpt/audiodecoder.openmpt.so.21.99.1"
        echo "✓ RPATH set for addon library"
    else
        echo "⚠ patchelf not found - RPATH not set (addon may fail to load)"
    fi
fi

echo "✓ Addon resources and library copied to $BUILD_DIR/audiodecoder.openmpt"
