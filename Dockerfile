# Build stage
FROM microsoft/aspnetcore-build:2 AS build-env

WORKDIR /generator

# restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj
COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# RUN ls -alR
# > docker build .
# OR
# Note: ls -alR requires Git Bash (i.e. MINGW) or Linux subsystem for windows
# > docker build -t testing .
# > docker run --rm testing ls -alR
# > docker run --rm -it -p 8080:80 testing

# pluralsight-pipeline-start-Working-Through-Course

# copy src
COPY . .

# test
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test tests/tests.csproj

# publish - note: will not occur unless test passes
RUN dotnet publish api/api.csproj -o /publish

# Runtime stage
FROM microsoft/aspnetcore:2
COPY --from=build-env /publish /publish
WORKDIR /publish

# test
# ENV TEAMCITY_PROJECT_NAME=fake
# ENV TEAMCITY_PROJECT_NAME=fake
# Set the flag to tell TeamCity that these are unit tests:
#ENV TEAMCITY_PROJECT_NAME = ${TEAMCITY_PROJECT_NAME}

ENTRYPOINT ["dotnet", "api.dll"]

# docker run --rm -it -p 8080:80 testing
