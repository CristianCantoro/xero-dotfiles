#!/usr/bin/env bash

##############################################################################
# SPARK
#
# add spark env variables
if [ -d '/opt/spark/spark' ]; then
  export SPARK_HOME='/opt/spark/spark'
  export PATH="$PATH:$SPARK_HOME/bin"
fi
