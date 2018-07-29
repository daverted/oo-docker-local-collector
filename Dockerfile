FROM timveil/oo-docker-base

LABEL maintainer="tjveil@gmail.com"

ARG SECRET_KEY=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1
ARG MACHINE_NAME=local-collector-container

RUN curl \
        -o overops-event-generator.jar \
        -L https://s3-us-west-1.amazonaws.com/overops/overops-event-generator-1.2.1.jar

RUN curl -sSL http://get.takipi.com/takipi-t4c-installer | bash /dev/stdin -i \
    --sk=$SECRET_KEY \
    --machine_name=$MACHINE_NAME \
    && rm -rf /opt/takipi/installation.key

ENTRYPOINT java -agentlib:TakipiAgent -Dtakipi.debug.logconsole -jar overops-event-generator.jar