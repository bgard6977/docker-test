FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openjdk-8-jdk
RUN apt-get install -y sudo git

RUN useradd -u 1001 -ms /bin/bash builder
USER 1001
WORKDIR /home/builder

ADD assemble /home/builder/assemble
ADD run /home/builder/run
LABEL io.openshift.s2i.scripts-url=image:///home/builder

EXPOSE 4567

CMD cat test.txt