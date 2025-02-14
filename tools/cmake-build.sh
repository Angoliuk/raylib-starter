#!/bin/bash

source "$(dirname "$0")/global.sh"

build_type=Release
target=wind
skip_configure=false
flags=()
wasm=false

call_dir=$(pwd)
root=""

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -sc|--skip-configure) skip_configure=true; ;;
    -bt|--build-type) build_type="$2"; shift ;;
    -wd|--with-dotnet) flags+=("-wd"); ;;
    -w|--wasm) wasm=true; flags+=("-w"); ;;
    -t|--target) target="$2"; shift ;;
    --root) root="$2"; shift ;;
    *) echo "Unknown parameter passed: $1" ;;
  esac
  shift
done

if [[ $skip_configure = false ]]; then
  wm run cmake-configure --build-type "$build_type" "${flags[@]}"
fi

if [ $wasm = true ]; then
  emmake cmake --build "$root/build/web/build/$build_type" --parallel 10 --target "$target" --verbose
else
  if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    cmake --build "$root/build/app/build/$build_type" --config Release --parallel 10 --target "$target" --verbose
  else
    cmake --build "$root/build/app/build/$build_type" --parallel 10 --target "$target" --verbose
  fi
fi


cd "$call_dir" || exit
