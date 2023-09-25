FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build-env
WORKDIR /src
COPY dockerizednet.csproj .
RUN dotnet restore "dockerizednet.csproj"
COPY . .
RUN dotnet publish "dockerizednet.csproj" -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine as runtime-env
WORKDIR /app
COPY --from=build-env /publish .

EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "dockerizednet.dll"]