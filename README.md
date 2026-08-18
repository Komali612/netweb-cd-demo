# netweb-cd-demo

A tiny **ASP.NET Core 8** web service used to smoke-test the `cicd-bootstrap`
CI → CD pipeline end to end.

- `GET /` → a greeting
- `GET /healthz` → `{ "status": "healthy" }`

It listens on **port 8080** (set via `ASPNETCORE_URLS` in the [Dockerfile](Dockerfile)),
so the CD agent classifies it as a **`web-service`** and deploys it with a
published port + HTTP health-check + automatic rollback.

Run locally:

```bash
docker build -t netweb-cd-demo .
docker run --rm -p 8080:8080 netweb-cd-demo
# then: curl http://localhost:8080/
```
