#!/usr/bin/env bash

##############################################################################
# Android
#
# Add Android Studio to PATH

if [ -d '/opt/android/android-studio/bin' ]; then
  export PATH="$PATH:/opt/android/android-studio/bin"
fi
