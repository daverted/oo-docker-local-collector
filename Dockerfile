####################################
#   Multi-stage build
#       1. build generator
#       2. build agent
####################################

# Stage 1 - Build Generator

FROM maven:3.5 as generator-builder

RUN git clone https://github.com/overops-samples/overops-event-generator.git /opt/overops-event-generator

RUN cd /opt/overops-event-generator \
    && mvn clean package -DskipTests=true


# Stage 2 - Build Agent

FROM timveil/oo-docker-base:latest

LABEL maintainer="tjveil@gmail.com"

ARG SECRET_KEY=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1
ARG MACHINE_NAME=local-collector-container

COPY --from=generator-builder /opt/overops-event-generator/target/overops-event-generator-*.jar .

RUN curl -sSL http://get.takipi.com/takipi-t4c-installer | bash /dev/stdin -i \
    --sk=$SECRET_KEY \
    --machine_name=$MACHINE_NAME \
    && rm -rf /opt/takipi/installation.key

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]