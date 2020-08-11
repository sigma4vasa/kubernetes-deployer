FROM alpine:3.12.0

LABEL maintainer="Gytis Tamulynas <Gytis@MPOServices.com>" \
    description="Kubernetes, helm, gpg, sstp, docker" \
    version="1.1.1"

# https://github.com/kubernetes/kubernetes/releases
ENV KUBECTL_VERSION="v1.18.6"
# https://github.com/kubernetes/helm/releases
ENV HELM_BASE_URL="https://get.helm.sh"
ENV HELM_VERSION="v3.3.0-rc.2"

COPY ./scripts/wait-for-ppp /usr/local/bin

RUN apk add \
    --no-cache \
    ca-certificates \
    bash \
    git \
    openssh \
    curl \
    gnupg \
    gcc \
    g++ \
    make \
    ppp-dev \
    libevent-dev \
    libressl-dev \
    libevent \
    libressl \
    zlib \
    ppp-pppoe \
    docker-cli \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q ${HELM_BASE_URL}/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && git clone https://github.com/sigma4vasa/sstp-client.git \
    && cd sstp-client \
    && ./configure --with-pppd-plugin-dir=/usr/lib/pppd/2.4.8 --with-runtime-dir=/usr/sbin/sstpc; make; make install \
    && cd ../ \
    && rm -rf sstp-client \
    && apk del gcc g++ make ppp-dev libevent-dev libressl-dev

WORKDIR /config

CMD bash
