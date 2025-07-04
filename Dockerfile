# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY . .
RUN dotnet restore "./ListCounterAPI/ListCounterAPI.csproj"
WORKDIR "/src/ListCounterAPI"
RUN dotnet build "./ListCounterAPI.csproj" -c $BUILD_CONFIGURATION -o /app/build --no-self-contained

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./ListCounterAPI.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
