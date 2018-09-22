FROM ubuntu:18.04

RUN echo "hello world" > test.txt && \
    chmod ugo+r test.txt

RUN useradd -u 1001 -ms /bin/bash builder
USER 1001
WORKDIR /home/builder

ADD assemble /home/builder/assemble
LABEL io.openshift.s2i.scripts-url=image:///home/builder

CMD cat test.txt