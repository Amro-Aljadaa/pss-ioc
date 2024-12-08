
FROM registry.docker.com/epics-modules as modules

# Fix libreadline symbolic link
# RUN ln -srf /usr/lib64/libreadline.so.7 /usr/lib64/libreadline.so

# Build the main IOC.
COPY    . /ioc
WORKDIR   /ioc
RUN       make

FROM    registry.docker.com/alpine
RUN     mkdir /ioc
WORKDIR /ioc

COPY --from=modules /ioc/db/    /ioc/db
COPY --from=modules /ioc/dbd/   /ioc/dbd
COPY --from=modules /ioc/bin/   /ioc/bin
COPY --from=modules /ioc/iocBoot/ioc/st.cmd /ioc/

# EPICS Base core libraries.
COPY --from=modules /opt/epics/base/lib/linux-x86_64/libdbRecStd.so.3.15 /opt/epics/base/lib/linux-x86_64/
COPY --from=modules /opt/epics/base/lib/linux-x86_64/libdbCore.so.3.15   /opt/epics/base/lib/linux-x86_64/
COPY --from=modules /opt/epics/base/lib/linux-x86_64/libca.so.3.15       /opt/epics/base/lib/linux-x86_64/
COPY --from=modules /opt/epics/base/lib/linux-x86_64/libCom.so.3.15      /opt/epics/base/lib/linux-x86_64/
COPY --from=modules /opt/epics/base/bin/linux-x86_64/caRepeater          /usr/bin/

# EPICS support modules.
COPY --from=modules /opt/epics/support/ether-ip/lib/linux-x86_64/libether_ip.so.3.3     /usr/lib64/
COPY --from=modules /opt/epics/support/iocstats/lib/linux-x86_64/libdevIocStats.so.3.1  /usr/lib64/

# OS.
COPY --from=modules /lib64/libstdc++.so.6          /lib64/
COPY --from=modules /lib64/libm.so.6               /lib64/
COPY --from=modules /lib64/libgcc_s.so.1           /lib64/
COPY --from=modules /lib64/libc.so.6               /lib64/
COPY --from=modules /lib64/libpthread.so.0         /lib64/
COPY --from=modules /lib64/libreadline.so.7        /lib64/
COPY --from=modules /lib64/librt.so.1              /lib64/
COPY --from=modules /lib64/libdl.so.2              /lib64/
COPY --from=modules /lib64/libtinfo.so.6           /lib64/
COPY --from=modules /lib64/ld-linux-x86-64.so.2    /lib64/
COPY --from=modules /usr/lib64/libxml2.so.2        /usr/lib64/
COPY --from=modules /usr/lib64/libtirpc.so.3       /usr/lib64/
COPY --from=modules /usr/lib64/libz.so.1           /usr/lib64/
COPY --from=modules /usr/lib64/liblzma.so.5        /usr/lib64/
COPY --from=modules /usr/lib64/libgssapi_krb5.so.2 /usr/lib64/
COPY --from=modules /usr/lib64/libkrb5.so.3        /usr/lib64/
COPY --from=modules /usr/lib64/libk5crypto.so.3    /usr/lib64/
COPY --from=modules /usr/lib64/libcom_err.so.2     /usr/lib64/
COPY --from=modules /usr/lib64/libkrb5support.so.0 /usr/lib64/
COPY --from=modules /usr/lib64/libcrypto.so.1.1    /usr/lib64/
COPY --from=modules /usr/lib64/libkeyutils.so.1    /usr/lib64/
COPY --from=modules /usr/lib64/libresolv.so.2      /usr/lib64/
COPY --from=modules /usr/lib64/libselinux.so.1     /usr/lib64/
# COPY --from=modules /usr/lib64/libpcre2-8.so.0     /usr/lib64/
COPY --from=modules /usr/lib64/libnss_dns.so.2     /usr/lib64/

# Run the IOC.
RUN /usr/bin/caRepeater &
CMD ["/ioc/bin/linux-x86_64/ioc", "/ioc/st.cmd"]
