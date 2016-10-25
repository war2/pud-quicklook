#! /usr/bin/env sh

set -e
set -u

WAR2TOOLS_DIR="war2tools"
BUILD_DIR="build"

log() {
   tput bold
   tput setaf 2
   echo "-- $*"
   tput sgr0
}

set -x

# Update submodules (get war2tools)
if [ ! -f "$WAR2TOOLS_DIR/CMakeLists.txt" ]; then
   log "Updating git submodules..."
   git submodule update --init --recursive
fi

# Creating build directory
log "Creating build directory: $(pwd)/$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Build war2tools (static libpud)
(
   cd "$BUILD_DIR"
   log "Generating Xcode project for war2tools (static libraries)"
   cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS:BOOL=OFF "../$WAR2TOOLS_DIR"

   log "Building war2tools"
   cmake --build .
)

