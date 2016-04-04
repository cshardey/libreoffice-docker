#!/bin/bash
#

set -e 

if [ "$1" == "run" ]
then
	exec $LIBREOFFICE_HOME/program/soffice.bin --nofirststartwizard --nologo --headless "--accept=socket,host=$HOST,port=$PORT;urp;StarOffice.ServiceManager"
else
	exec "$@"
fi


