FROM ubuntu:18.04

RUN echo "hello world" > test.txt

CMD cat test.txt