FROM ubuntu:22.04 as builder


RUN apt-get update && apt-get install -y wget && \
    mkdir actions-runner && \
    mkdir actions-runner/creds && \
    cd actions-runner && \
    wget https://github.com/actions/runner/releases/download/v2.301.1/actions-runner-linux-x64-2.301.1.tar.gz && \
    tar xzf ./actions-runner-linux-x64-2.301.1.tar.gz && \
    rm ./actions-runner-linux-x64-2.301.1.tar.gz
USER root
WORKDIR actions-runner
COPY ./entrypoint.sh ./entrypoint.sh
RUN useradd -ms /bin/bash appuser && chown -R appuser:appuser ../actions-runner
RUN ./bin/installdependencies.sh

FROM ubuntu:22.04 as image
COPY --from=builder / /
WORKDIR actions-runner
USER appuser

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./run.sh"]

