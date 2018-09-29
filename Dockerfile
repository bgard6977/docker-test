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
RUN apt-get install net-tools telnet
RUN sudo sed -i "s/peer/trust/g" /etc/postgresql/10/main/pg_hba.conf && \
    service postgresql start && \
    createdb -U postgres volcano && \
    createdb -U postgres volcano_test && \
    service postgresql stop

# OpenShift
RUN echo "postgres ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers 
USER 104
WORKDIR /var/lib/postgresql
ADD assemble /var/lib/postgresql/assemble
ADD run /var/lib/postgresql/run
LABEL io.openshift.s2i.scripts-url=image:///var/lib/postgresql

EXPOSE 8080

CMD cat test.txt