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
    jq \
    iptables
    
RUN curl -sSL https://get.docker.com/ | sh

# Install latest docker compose.
RUN VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r) && \
	DESTINATION=/usr/local/bin/docker-compose && \
	curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION && \
	chmod 755 $DESTINATION

RUN usermod -aG docker jenkins

CMD dockerd