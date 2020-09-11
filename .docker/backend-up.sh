#!/bin/bash
echo "1. Removing Wallet SPA..."
docker-compose build accounts-api
docker-compose build identity-server
docker-compose rm -fsv wallet-spa
echo "2. Starting up SQL Server in Docker..."
docker-compose up -d sql1
echo "3. Installing Entity Framework Tool to migrate databases."
dotnet tool update --global dotnet-ef --version 3.1.7
echo "4. Generating accounts schema in DB..."
dotnet ef database update --project ../accounts-api/src/Infrastructure --startup-project ../accounts-api/src/WebApi
echo "5. Starting up Identity Server and Accounts applications."
docker-compose up -d accounts-api
docker-compose up -d identity-server