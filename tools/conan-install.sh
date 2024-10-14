#!/bin/bash

source "$(dirname "$0")/global.sh"

build_type=Release
wasm=false

call_dir=$(pwd)
root=""

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -bt|--build-type) build_type="$2"; shift; ;;
    -w|--wasm) wasm=true; ;;
    --root) root="$2"; shift; ;;
    *) echo "Unknown parameter passed: $1" ;;
  esac
  shift
done

cd "$root" || exit

if [ $wasm = true ]; then
  conan install --output-folder build/web . -o *:shared=False --build=missing -s build_type="$build_type" --profile wasm
else
  conan install --output-folder build/app . --build=missing -s build_type="$build_type"
fi


cd "$call_dir" || exit
