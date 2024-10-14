#!/bin/bash

source "$(dirname "$0")/global.sh"

call_dir=$(pwd)
wasm=false
root=""

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --root) root="$2"; shift; ;;
    -w|--wasm) wasm=true; ;;
    *) echo "Unknown parameter passed: $1" ;;
  esac
  shift
done

cd "$root" || exit

if [ $wasm = true ]; then
  conan install . -o *:shared=False --build=missing --deployer-package=wind --deployer=full_deploy --deployer-folder="$root"/conan-deploy/web --profile wasm
else
  conan install . --build=missing --deployer-package=wind --deployer=full_deploy --deployer-folder="$root"/conan-deploy/app
fi

cd "$call_dir" || exit
