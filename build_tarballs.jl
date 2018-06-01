# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

# Collection of sources required to build CMakeBuilder
sources = [
    "https://cmake.org/files/v3.11/cmake-3.11.3.tar.gz" =>
    "287135b6beb7ffc1ccd02707271080bbf14c21d80c067ae2c0040e5f3508c39a",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/cmake-*/
cmake -DCMAKE_INSTALL_PREFIX=$prefix
make -j${nproc}
make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, :glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "CMakeBuilder", sources, script, platforms, products, dependencies)

