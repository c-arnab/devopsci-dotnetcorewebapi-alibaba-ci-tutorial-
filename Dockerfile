FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS base
WORKDIR /app
ENV ASPNETCORE_URLS http://+:5000
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY ["dotnetcorewebapi-alibaba-ci-tutorial.csproj", "./"]
RUN dotnet restore "./dotnetcorewebapi-alibaba-ci-tutorial.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "dotnetcorewebapi-alibaba-ci-tutorial.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "dotnetcorewebapi-alibaba-ci-tutorial.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "dotnetcorewebapi-alibaba-ci-tutorial.dll"]
