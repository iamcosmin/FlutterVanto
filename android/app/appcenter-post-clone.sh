#!/usr/bin/env bash
#Place this script in project/android/app/

cd ..

# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b beta https://github.com/flutter/flutter.git

echo "Flutter este descarcat."

export PATH=`pwd`/flutter/bin:$PATH

echo "Variabila adaugata"

flutter channel beta
echo "Comutat la beta."
flutter doctor

echo "Installed flutter to `pwd`/flutter"

flutter build appbundle

echo "Aplicatie construita."

mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app.aab $_