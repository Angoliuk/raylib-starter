#!/bin/bash

source "$(dirname "$0")/global.sh"

build_type=Release
flags=()
wasm=false

call_dir=$(pwd)
root=""

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -bt|--build-type) build_type="$2"; shift ;;
    -wd|--with-dotnet) flags+=("-DBUILD_DOTNET=ON"); ;;
    -w|--wasm) wasm=true; flags+=("-DBUILD_WASM=ON"); ;;
    --root) root="$2"; shift ;;
    *) echo "Unknown parameter passed: $1" ;;
  esac
  shift
done

cd "$root" || exit

if [ $wasm = true ]; then
  cmake -G "Unix Makefiles" -DCMAKE_POLICY_DEFAULT_CMP0091=NEW -DCMAKE_BUILD_TYPE="$build_type" -DCMAKE_TOOLCHAIN_FILE="$root/build/web/build/$build_type/generators/conan_toolchain.cmake" -S"$root" -B"$root/build/web/build/$build_type" "${flags[@]}"
else
  if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    cmake -G "Visual Studio 17 2022" -DCMAKE_POLICY_DEFAULT_CMP0091=NEW -DCMAKE_BUILD_TYPE="$build_type" -DCMAKE_TOOLCHAIN_FILE="$root/build/app/build/generators/conan_toolchain.cmake" -S"$root" -B"$root/build/app/build/$build_type" "${flags[@]}"
  else
    cmake -G "Unix Makefiles" -DCMAKE_POLICY_DEFAULT_CMP0091=NEW -DCMAKE_BUILD_TYPE="$build_type" -DCMAKE_TOOLCHAIN_FILE="$root/build/app/build/$build_type/generators/conan_toolchain.cmake" -S"$root" -B"$root/build/app/build/$build_type" "${flags[@]}"
  fi
fi

cd "$call_dir" || exit
