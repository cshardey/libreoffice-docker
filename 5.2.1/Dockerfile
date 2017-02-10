FROM keensoft/centos7-java8
MAINTAINER keensoft.es
RUN set -x \
	&& yum update -y \
	&& yum install -y \
    		cairo \
    		cups-libs \
    		fontconfig \
    		libSM \ 
    		libICE \
    		libXrender \
    		libXext \
    		mesa-libGLU.x86_64 \
    		tar \
    		wget \
	&& yum clean all

ENV LIBREOFFICE_VERSION="5.2.1-alfresco" \
	LIBREOFFICE_DOWNLOAD_MIRROR="https://artifacts.alfresco.com/nexus/service/local/repositories/thirdparty/content/org/libreoffice/libreoffice-dist/" \
	LIBREOFFICE_PORT="8100" \
	LIBREOFFICE_HOST="0.0.0.0" \
	LANG="es_ES.utf8"

ENV LIBREOFFICE_TGZ="libreoffice-dist-$LIBREOFFICE_VERSION-linux.tgz"
ENV LIBREOFFICE_DIST_URL="${LIBREOFFICE_DOWNLOAD_MIRROR}/${LIBREOFFICE_VERSION}/${LIBREOFFICE_TGZ}"

RUN set -x \
	&& wget ${LIBREOFFICE_DIST_URL} \
	&& tar xzvf ${LIBREOFFICE_TGZ} \
	&& rm -rf ${LIBREOFFICE_TGZ}

RUN set -x \
	&& sed -i 's,@@BITROCK_LO_ROOTDIR@@,/libreoffice,g' /libreoffice/scripts/ctl.sh \
	&& sed -i 's,@@BITROCK_LO_PORT@@,'"$LIBREOFFICE_PORT"',g' /libreoffice/scripts/ctl.sh \
	&& sed -i 's,host=localhost,host='"$LIBREOFFICE_HOST"',g' /libreoffice/scripts/ctl.sh \
	&& sed -i 's,@@BITROCK_LO_ROOTDIR@@,/libreoffice,g' /libreoffice/program/bootstraprc \
	&& sed -i 's,@@BITROCK_LO_ROOTDIR@@,/libreoffice,g' /libreoffice/program/soffice.bin \
	&& chmod +x /libreoffice/scripts/ctl.sh

COPY assets/libreoffice_ctl.sh /libreoffice/libreoffice_ctl.sh

RUN set -x \
	&& chmod +x /libreoffice/libreoffice_ctl.sh \
	&& useradd -ms /bin/bash libreoffice \
	&& chown -R libreoffice:libreoffice /libreoffice \
	&& mkdir /tmp/libreoffice \
	&& chown libreoffice:libreoffice /tmp/libreoffice

USER libreoffice
WORKDIR /libreoffice
EXPOSE ${LIBREOFFICE_PORT}
ENTRYPOINT ["/libreoffice/libreoffice_ctl.sh"]
CMD ["run"]
