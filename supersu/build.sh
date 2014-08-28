#!/bin/bash

# variables
VERSION="v2.01"
TOOLS="../SignApk/Tools"
OUTDIR="OUT"
ZIP1="unsigned.zip"
ZIP2="UPDATE-SuperSU-${VERSION}.zip"

# for clean build
rm -rf ${OUTDIR}
mkdir ${OUTDIR}
find . -type f -name '*~' -delete


# build
zip -r ${OUTDIR}/${ZIP1} system META-INF
java -jar ${TOOLS}/signapk.jar -w ${TOOLS}/testkey.x509.pem ${TOOLS}/testkey.pk8 ${OUTDIR}/${ZIP1} ${OUTDIR}/${ZIP2}
rm -f ${OUTDIR}/${ZIP1}
