FROM centos:8

RUN yum install python3-pip yum-utils unzip rsync -y && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install docker-ce-cli -y && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN curl -LO https://github.com/openshift/source-to-image/releases/download/v1.3.0/source-to-image-v1.3.0-eed2850f-linux-amd64.tar.gz && \
    tar xzvf source-to-image-v1.3.0-eed2850f-linux-amd64.tar.gz && \
    chmod +x s2i && \
    mv s2i sti /usr/bin/ && \
    rm -f source-to-image-v1.3.0-eed2850f-linux-amd64.tar.gz && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/v1.14.1/bin/linux/amd64/kubectl > /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl && \
    pip3 install -U awscli --no-cache-dir && \
    mkdir -p /home/build/src/

WORKDIR /home/build

COPY worker-build /usr/bin/
COPY .s2i ./src/.s2i

CMD ["/bin/bash", "/usr/bin/worker-build"]
