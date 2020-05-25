# PowerShell : Get-Content containerScan.Dockerfile | docker build -t localhost:55000/containerScan.Dockerfile:v3.1 -
# DOS : docker build -t agents/container-scan:latest - < containerScan.Dockerfile
#     : docker tag agents/container-scan:latest localhost:55000/agents/container-scan:latest
#     : docker push localhost:55000/agents/container-scan:latest
#     : docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock localhost:55000/agents/container-scan:latest
#     : docker exec -it --user jenkins REPLACE_WITH_DOCKER_PS_NAME /bin/bash

FROM jenkins/jenkins:lts

USER root
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    jq \
    iptables \
	wget  \
	apt-transport-https  \
	gnupg  \
	lsb-release
    
RUN curl -sSL https://get.docker.com/ | sh

# Install the .Net Core framework, set the path, and show the version of core installed.
RUN VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r) && \
	DESTINATION=/usr/local/bin/docker-compose && \
	curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION && \
	chmod 755 $DESTINATION

# Install Trivy container scanner https://github.com/aquasecurity/trivy
RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
RUN echo deb https://aquasecurity.github.io/trivy-repo/deb bionic main | tee -a /etc/apt/sources.list.d/trivy.list
RUN apt-get update
RUN apt-get install -y trivy

RUN usermod -aG docker jenkins

CMD dockerd