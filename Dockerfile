FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["Sml.Poc.NetCore.GithubActions.Api/Sml.Poc.NetCore.GithubActions.Api.csproj", "Sml.Poc.NetCore.GithubActions.Api/"]
RUN dotnet restore "./Sml.Poc.NetCore.GithubActions.Api/./Sml.Poc.NetCore.GithubActions.Api.csproj"
COPY . .
WORKDIR "/src/Sml.Poc.NetCore.GithubActions"
RUN dotnet build "./Sml.Poc.NetCore.GithubActions.Api.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./Sml.Poc.NetCore.GithubActions.Api.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Sml.Poc.NetCore.GithubActions.Api.dll"]
