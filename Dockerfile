FROM registry.nestybox.com/nestybox/ubuntu-bionic-systemd-docker

RUN curl https://packages.microsoft.com/config/ubuntu/18.04/multiarch/prod.list > ./microsoft-prod.list &&\
  cp ./microsoft-prod.list /etc/apt/sources.list.d/ &&\
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg &&\
  cp ./microsoft.gpg /etc/apt/trusted.gpg.d/ &&\
  apt-get update &&\
  apt-get install -y moby-engine nano aziot-edge &&\
  #mkdir -p /etc/aziot/config &&\
  #touch /etc/aziot/config/config.toml &&\
  ln -s /etc/aziot/config/config.toml /etc/aziot/config.toml &&\
  rm -rf /var/lib/{apt,dpkg,cache,log}/ &&\
  printf '[Unit] \nDescription=FOO BAR \n \n[Service] \nType=oneshot \nExecStart=/usr/bin/iotedge config apply \n \n[Install] \nWantedBy=aziot-edged.service' \
   >> /etc/systemd/system/aziot-init.service &&\
  systemctl enable aziot-init.service
  
# connect CM to /etc/aziot/config/config.toml
