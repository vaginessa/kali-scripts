#!/bin/bash

# variables
OUTDIR="OUT"

# for clean build
rm -rf ${OUTDIR}
find . -type f -name '*~' -delete
