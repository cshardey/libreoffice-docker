# https://artifacts.alfresco.com/nexus/service/local/repositories/thirdparty/content/org/libreoffice/libreoffice-dist/4.4.5-20151016/libreoffice-dist-4.4.5-20151016-linux.tgz
FROM keensoft/centos7-java8
MAINTAINER Mikel Asla mikel.asla@keensoft.es
RUN yum update -y
RUN yum install -y \
    wget \
    tar \
    fontconfig \
    libSM \ 
    libICE \
    libXrender \
    libXext \
    cups-libs \
    cairo

ENV LIBREOFFICE_VERSION="5.1.1" \
	LIBREOFFICE_VERSION_MINOR="5.1.1.3" \
	LIBREOFFICE_DOWNLOAD_MIRROR="http://download.documentfoundation.org/libreoffice/stable" \
	HOST="0.0.0.0" \
	PORT="8100" \
	LIBREOFFICE_HOME="/opt/libreoffice5.1" \
	LANG="es_ES.utf8"

ENV LIBREOFFICE_RPM_TGZ="LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_rpm.tar.gz" \
	LIBREOFFICE_RPM_DIR="LibreOffice_${LIBREOFFICE_VERSION_MINOR}_Linux_x86-64_rpm" \
	LIBREOFFICE_ES_RPM_DIR="LibreOffice_${LIBREOFFICE_VERSION_MINOR}_Linux_x86-64_rpm_langpack_es" \
	LIBREOFFICE_ES_RPM_TGZ="LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_rpm_langpack_es.tar.gz"
	
ENV LIBREOFFICE_RPM_URL="${LIBREOFFICE_DOWNLOAD_MIRROR}/${LIBREOFFICE_VERSION}/rpm/x86_64/${LIBREOFFICE_RPM_TGZ}" \
	LIBREOFFICE_ES_RPM_URL="${LIBREOFFICE_DOWNLOAD_MIRROR}/${LIBREOFFICE_VERSION}/rpm/x86_64/${LIBREOFFICE_ES_RPM_TGZ}" 

RUN set -x \
	&& wget ${LIBREOFFICE_RPM_URL} \
	&& tar xzvf ${LIBREOFFICE_RPM_TGZ} \
	&& cd ${LIBREOFFICE_RPM_DIR}/RPMS \
	&& yum install -y *.rpm \
	&& cd \
	&& rm -rf ${LIBREOFFICE_RPM_DIR} ${LIBREOFFICE_RPM_TGZ}

RUN set -x \
	&& wget ${LIBREOFFICE_ES_RPM_URL} \
	&& tar xzvf ${LIBREOFFICE_ES_RPM_TGZ} \
	&& cd ${LIBREOFFICE_ES_RPM_DIR}/RPMS \
	&& yum install -y *.rpm \
	&& cd \
	&& rm -rf ${LIBREOFFICE_ES_RPM_DIR} ${LIBREOFFICE_ES_RPM_TGZ}

RUN useradd -ms /bin/bash libreoffice
RUN chown -R libreoffice:libreoffice $LIBREOFFICE_HOME
USER libreoffice
WORKDIR $LIBREOFFICE_HOME
ENV PATH $LIBREOFFICE_HOME/program:$PATH
EXPOSE ${PORT}
CMD tail -f /dev/null && soffice.bin --nofirststartwizard --nologo --norestore --invisible --headless --accept="socket,host=0.0.0.0,port=8100,tcpNoDelay=1;urp;"
