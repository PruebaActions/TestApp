# Fase de construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY ActionsSetUp/*.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /app/out --no-restore

# Fase de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

EXPOSE 8080
ENTRYPOINT ["dotnet", "ActionSetUp.dll"]
