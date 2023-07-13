FROM ubuntu:22.04

#ENV container docker
ENV LANG=C.utf8

RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

RUN apt-get update; \
    apt-get install -y \
    bash \
    coreutils \
    crypto-policies \
    findutils \
    gdbserver \
    gzip \
    curl \
    libuser \
    passwd \
    procps \
    systemd \
    systemd-sysv \
    tar \
    usermode \
    vim \
    virt-what; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
    cd /lib/systemd/system/sysinit.target.wants/; \
    ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1; \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*; \
    rm -f /lib/systemd/system/plymouth*; \
    rm -f /lib/systemd/system/systemd-update-utmp*

RUN systemctl set-default multi-user.target; \
    systemctl mask systemd-remount-fs.service \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    systemd-logind.service \
    getty.target \
    console-getty.service \
    systemd-udev-trigger.service \
    systemd-udevd.service \
    systemd-random-seed.service \
    systemd-machine-id-commit.service

CMD ["/sbin/init"]

STOPSIGNAL SIGRTMIN+3