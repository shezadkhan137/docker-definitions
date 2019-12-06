FROM python:3.8

WORKDIR /opt

COPY install_yara.sh /opt/install_yara.sh
RUN ./install_yara.sh && rm install_yara.sh
