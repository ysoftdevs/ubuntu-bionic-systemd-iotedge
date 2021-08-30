FROM registry.nestybox.com/nestybox/ubuntu-bionic-systemd-docker

RUN curl https://packages.microsoft.com/config/ubuntu/18.04/multiarch/prod.list > ./microsoft-prod.list &&\
  cp ./microsoft-prod.list /etc/apt/sources.list.d/ &&\
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg &&\
  cp ./microsoft.gpg /etc/apt/trusted.gpg.d/ &&\
  apt-get update &&\
  apt-get install -y moby-engine nano aziot-edge &&\
# connect CM to /etc/aziot/config.toml
# iotedge config apply