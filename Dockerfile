FROM hiracchi/ubuntu-ja:18.04.1

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/hiracchi/docker-pwff" \
      org.label-schema.version=$VERSION \
      maintainer="Toshiyuki Hirano <hiracchi@gmail.com>"


ARG WORKDIR="/work"

# setup packages ===============================================================
RUN set -x \
  && apt-get update \
  && apt-get install -y \
     make \
     python3 python3-pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN set -x \
  && pip3 install django

# -----------------------------------------------------------------------------
# entrypoint
# -----------------------------------------------------------------------------
COPY usage.sh /usr/local/bin

RUN set -x \
  && mkdir -p ${WORKDIR}
WORKDIR "${WORKDIR}"
CMD ["/usr/local/bin/usage.sh"]
