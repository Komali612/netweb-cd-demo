# Multi-stage build for the ASP.NET web service.
# The runtime stage EXPOSEs 8080 and forces the app to listen there, so the CD
# agent classifies this as a `web-service` (port 8080) and the deploy's HTTP
# health-check on :8080 succeeds.
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore src/NetWebCdDemo/NetWebCdDemo.csproj
RUN dotnet publish src/NetWebCdDemo/NetWebCdDemo.csproj -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app ./
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "NetWebCdDemo.dll"]
