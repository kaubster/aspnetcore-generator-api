# PowerShell : Get-Content jenkinsdocker.Dockerfile | docker build -t localhost:55000/jenkinsdocker:v3.1 -
# DOS : docker build -t agents/jenkinsdocker:latest - < jenkinsdocker.Dockerfile
#     : docker tag agents/jenkinsdocker:latest localhost:55000/agents/jenkinsdocker:latest
#     : docker push localhost:55000/agents/jenkinsdocker:latest
#     : docker run --privileged localhost:55000/agents/jenkinsdocker:latest
#     : docker exec -it --user jenkins REPLACE_WITH_DOCKER_PS_NAME /bin/bash

FROM jenkins/jenkins:lts

USER root
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
RUN curl -sSL https://get.docker.com/ | sh

RUN usermod -aG docker jenkins

CMD dockerd