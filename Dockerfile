FROM ubuntu:24.04 AS build

RUN apt-get update \
    && apt-get install -y --no-install-recommends g++ cmake make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
    && cmake --build build -j"$(nproc)"

FROM ubuntu:24.04 AS runtime

RUN apt-get update \
    && apt-get install -y --no-install-recommends libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=build /app/build/mv-cloudcore-engine /app/mv-cloudcore-engine

ENV ENGINE_CORES=8
ENV ENGINE_MEMORY_MB=16384
ENV ENGINE_WORKERS=4
ENV ENGINE_POLICY=MLFQ
ENV ENGINE_HTTP_THREADS=8

EXPOSE 9090

CMD ["/app/mv-cloudcore-engine"]
