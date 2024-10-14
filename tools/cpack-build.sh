#!/bin/bash

source "$(dirname "$0")/global.sh"

build_type=Release
output_folder=releases

call_dir=$(pwd)
root=""
wasm=false

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -bt|--build-type) build_type="$2"; shift ;;
    -o|--output) output_folder="$2"; shift ;;
    -w|--wasm) wasm=true; ;;
    --root) root="$2"; shift ;;
    *) echo "Unknown parameter passed: $1" ;;
  esac
  shift
done

if [ $wasm = true ]; then
  cd "$root/build/web/build/$build_type" || exit
else
  cd "$root/build/app/build/$build_type" || exit
fi

cpack -B "$root/$output_folder"

cd "$call_dir" || exit
