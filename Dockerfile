FROM ubuntu:18.04

# JDK
RUN apt-get update && apt-get install -y openjdk-8-jdk
RUN apt-get install -y sudo git wget nano curl

# chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
RUN apt-get install -y \
    gdebi unzip fonts-liberation libappindicator3-1 libasound2 libxss1 xdg-utils \
    libasound2-data libdbusmenu-glib4 libdbusmenu-gtk3-4 libindicator3-7 libnspr4 libnss3
RUN dpkg -i google-chrome-stable_current_amd64.deb

# chromedriver
RUN wget -q https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
RUN apt-get install -y libnss3 libgconf-2-4
RUN unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/bin && \
    chromedriver --version

# postgres
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql postgresql-contrib

# OpenShift
RUN useradd -u 1001 -ms /bin/bash builder
USER 1001
WORKDIR /home/builder
ADD assemble /home/builder/assemble
ADD run /home/builder/run
LABEL io.openshift.s2i.scripts-url=image:///home/builder

EXPOSE 4567

CMD cat test.txt