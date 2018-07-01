# OverOps Docker Image for Agent and Local Collector

__*Please note, this is not an official OverOps repository or Docker image*__

This image contains an [OverOps](http://www.overops.com) Agent which talks to a Local Collector.  The Agent attaches to a single JVM running a sample application which generates errors.  More info on this image can be found on [DockerHub](https://hub.docker.com/r/timveil/oo-docker-local-collector/).

Although the image contains defaults for all *build* arguments (see `docker build` and `--build-arg`), to function properly, the image must be built with actual values from your environment or passed to the image using the appropriate *run* time environment variable (see `docker run` and `-e`).  This image accepts the following parameters.

## Build and Run Parameters

*Currently build arguments passed to the `Dockerfile` are removed in favor of their environment variable equivalents which should be provided when executing `docker run`.*

| build-arg | default value | environment variable | note |
| --- | --- | --- | --- |
| `SECRET_KEY` | see Dockerfile | `TAKIPI_SECRET_KEY` | default secret key is invalid and must be replaced |
| `MACHINE_NAME` | `agent-local-collector` | `TAKIPI_MACHINE_NAME` | human readable name of the container |


## Examples

#### Building the Image

```bash
docker build \
    --no-cache \
    -t timveil/oo-docker-local-collector:latest \
    --build-arg SECRET_KEY="S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1" \
    --build-arg MACHINE_NAME=agent-local-collector .
```

#### Publishing the Image

```bash
docker push timveil/oo-docker-local-collector:latest
```

#### Running the Image

```bash
docker run \
    -e TAKIPI_SECRET_KEY="S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1" \
    -e MACHINE_NAME=agent-local-collector \
    timveil/oo-docker-local-collector
```