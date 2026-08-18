// A real, long-running ASP.NET Core web service — the CD smoke-test target.
// It listens on port 8080 (set via ASPNETCORE_URLS in the Dockerfile) so the
// CD "web-service" deploy recipe (publish 8080 -> HTTP health-check) passes.
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () =>
    "Hello from netweb-cd-demo! 🚀 A real .NET web service, deployed to this " +
    "laptop by the cicd-bootstrap CD agent (web-service recipe).");

app.MapGet("/healthz", () => Results.Ok(new { status = "healthy" }));

app.Run();
