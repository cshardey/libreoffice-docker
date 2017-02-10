#!/bin/sh

SOFFICE_BIN=/libreoffice/program/soffice.bin
SOFFICE_ARGS="'--accept=socket,host=${LIBREOFFICE_HOST},port=${LIBREOFFICE_PORT};urp;StarOffice.ServiceManager' -env:UserInstallation=file:///tmp/libreoffice --headless --nocrashreport --nofirststartwizard --nologo --norestore"

if [ "$1" = "run" ]; then

	$SOFFICE_BIN "$SOFFICE_ARGS"
else
	exec "$@"

fi
