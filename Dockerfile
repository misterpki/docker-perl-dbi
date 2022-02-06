FROM perl:latest

ENV ORACLE_HOME=/opt/instantclient_11_2/
ENV LD_LIBRARY_PATH=/opt/instantclient_11_2/
ENV C_INCLUDE_PATH=/opt/instantclient_11_2/sdk/include/

COPY dependencies/* /opt/

WORKDIR /opt

RUN apt-get update && \
    apt-get install -y libaio1 && \
    unzip instantclient-basic-linux.x64-11.2.0.4.0.zip && \
    unzip instantclient-sdk-linux.x64-11.2.0.4.0.zip -d /opt/instantclient_11_2 && \
    mv /opt/instantclient_11_2/instantclient_11_2/sdk /opt/instantclient_11_2 && \
    rm -r /opt/instantclient_11_2/instantclient_11_2/ && \
    tar -xzvf DBD-Oracle-1.83.tar.gz && \
    perl -MCPAN -e 'install Bundle::DBI' && \
    cd DBD-Oracle-1.83 && \
    perl Makefile.PL -V 11.2.0 && \
    make install
