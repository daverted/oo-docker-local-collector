FROM timveil/oo-docker-base

LABEL maintainer="tjveil@gmail.com"

ARG SECRET_KEY=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1
ARG MACHINE_NAME=agent-local-collector

RUN curl -sSL http://get.takipi.com/takipi-t4c-installer | bash /dev/stdin -i \
    --sk=$SECRET_KEY \
    --machine_name=$MACHINE_NAME \
    && rm -rf /opt/takipi/installation.key

ENTRYPOINT java -agentlib:TakipiAgent -Dtakipi.debug.logconsole -jar overops-event-generator.jar