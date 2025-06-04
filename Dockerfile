# Stage 1: Build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the project file explicitly
COPY ListCounterAPI/*.csproj ./ListCounterAPI/
WORKDIR /app/ListCounterAPI

# Restore dependencies
RUN dotnet restore

# Copy all source code
COPY . ./

# Publish the release build
RUN dotnet publish -c Release -o /app/out

# Stage 2: Create runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy published files from build stage
COPY --from=build /app/out ./

# Expose port 80
EXPOSE 80

# Set the entry point to run your app
ENTRYPOINT ["dotnet", "ListCounterAPI.dll"]
