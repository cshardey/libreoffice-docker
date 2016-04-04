#!/bin/sh

SOFFICEWRAPPER=/libreoffice/program/soffice.bin
SOFFICE="$SOFFICEWRAPPER "--accept=socket,host=${LIBREOFFICE_HOST},port=${LIBREOFFICE_PORT}\;urp\;StarOffice.ServiceManager" -env:UserInstallation=file:///tmp --headless --nocrashreport --nofirststartwizard --nologo --norestore"

if [ "$1" = "run" ]; then

     	exec $SOFFICE >/dev/null 2>&1
else
	exec "$@"

fi
