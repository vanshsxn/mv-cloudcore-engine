# MV CloudCore Engine

A C++ job engine with MLFQ scheduling, resource management, and per-tenant
credit billing. Every executed CPU slice is charged against the tenant's
credit pool; jobs that would exceed the balance are rejected up front and
refunded if they cannot start.

## Build

```bash
g++ -std=c++17 -O2 -pthread src/*.cpp -o engine
```

## Run

```bash
PORT=10000 ./engine
```

The engine binds to `0.0.0.0` on the port given by `PORT` (default 9090).
On Render: build command `g++ -std=c++17 -O2 -pthread src/*.cpp -o engine`,
start command `PORT=10000 ./engine`.

## Endpoints

| Method | Path                   | Purpose                                        |
|--------|------------------------|------------------------------------------------|
| GET    | /health                | Health check (status, policy, workers, paused) |
| POST   | /api/jobs              | Submit a job                                   |
| GET    | /api/jobs              | List jobs (supports tenantId filter)           |
| GET    | /api/jobs/:id          | Get one job (includes workerId when executed)  |
| DELETE | /api/jobs/:id          | Cancel/remove a job                            |
| POST   | /api/engine/pause      | Pause the engine                               |
| POST   | /api/engine/resume     | Resume the engine                              |
| GET    | /api/tenants           | Tenants and credit balances                    |
| POST   | /api/tenants/credits   | Adjust a tenant's credits                      |
| GET    | /api/metrics           | Engine metrics                                 |
| GET    | /api/resources         | Resource usage                                 |
| GET    | /api/memory            | Memory manager state                           |
| GET    | /api/scheduler/queues  | MLFQ queue state                               |
| POST   | /api/scheduler/policy  | Change scheduling policy                       |
| GET    | /api/logs              | Log entries                                    |

## Billing behavior

- Admission: a job is rejected if the tenant's balance cannot cover
  `estimatedCredits()` (cores × duration estimate).
- Execution: each CPU slice charges the tenant via `Engine::chargeTenant`
  (thread-safe, balance clamped to 0, returns the new balance) and the
  per-slice cost is logged.
- Workers: each job records the thread-pool worker that ran it in `workerId`.
- Credits come from the tenant record (`credits` field, parsed with
  `std::stod`); adjust balances with `POST /api/tenants/credits`.

## Layout

- `include/` — headers (Engine, Job, JobQueue, ThreadPool, schedulers,
  ResourceManager, MemoryManager, HttpServer, Json, Logger)
- `src/` — implementations and `main.cpp`
