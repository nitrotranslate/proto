FROM connysh/conny:v0.5.0

COPY descriptor.pb /descriptor.pb

ENV DESCRIPTOR=/descriptor.pb
ENV PAYMENT=true