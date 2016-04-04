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
    mesa-libGLU.x86_64 \
    cups-libs \
    cairo

ENV LIBREOFFICE_VERSION="4.4.5-20151016" \
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
	&& chown -R libreoffice:libreoffice /libreoffice

USER libreoffice
WORKDIR /libreoffice
EXPOSE ${LIBREOFFICE_PORT}
ENTRYPOINT ["/libreoffice/libreoffice_ctl.sh"]
CMD ["run"]
