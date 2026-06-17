FROM connysh/conny:latest

COPY descriptor.pb /descriptor.pb

ENV DESCRIPTOR=/descriptor.pb
