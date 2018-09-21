FROM ubuntu:18.04

RUN echo "hello world" > test.txt && \
    chmod ugo+r test.txt

USER nobody

CMD cat test.txt