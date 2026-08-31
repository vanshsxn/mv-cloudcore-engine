# MV CloudCore Engine

C++ core engine for the SmartDatabaseOS project.

## Components

- MLFQ scheduler
- Adaptive scheduler
- Best-Fit memory manager
- Resource manager
- Thread pool
- Job queue
- Hand-written HTTP/1.1 server using POSIX/BSD sockets

## Build locally

```bash
cmake -S . -B build
cmake --build build
./build/mv-cloudcore-engine
```

The engine listens on `PORT` when provided. For local development it falls back to `ENGINE_PORT`, then `9090`.

## Health check

```bash
curl http://localhost:9090/health
```

## Render

Deploy this repository as a **Web Service** using **Docker**.

Render supplies the `PORT` environment variable. The engine reads it automatically and binds to `0.0.0.0`.

Do not put PostgreSQL credentials in this repository. The current engine does not yet contain a PostgreSQL client/connection layer; database persistence should be added as a separate server-side module before relying on PostgreSQL in production.

## API

- `GET /health`
- `POST /api/jobs`
- `GET /api/jobs`
- `GET /api/jobs/:id`
- `DELETE /api/jobs/:id`
- `POST /api/engine/pause`
- `POST /api/engine/resume`
- `GET /api/tenants`
- `GET /api/metrics`
- `GET /api/resources`
- `GET /api/memory`
- `GET /api/scheduler/queues`
- `POST /api/scheduler/policy`
- `POST /api/tenants/credits`
- `GET /api/logs`
