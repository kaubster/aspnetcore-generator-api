#!/bin/sh
# Get the registration token from:
# http://localhost:8080/root/${project}/settings/ci_cd


#docker run -d --name gitlab-runner --restart always \
# -v /srv/gitlab-runner/config:/etc/gitlab-runner \
#  -v /var/run/docker.sock:/var/run/docker.sock \
#  gitlab/gitlab-runner:latest

#docker run --rm -t -i -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register


registration_token=NnFewzKoE-VukY6b5Tac

docker run --rm -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:latest \
  --url "http://localhost:8929/" \
  --registration-token ${registration_token} \
  --description "docker-runner" \
  --tag-list "docker,aws" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"
  
#docker exec -it gitlab-runner \
#  gitlab-runner register \
#    --non-interactive \
#    --registration-token ${registration_token} \
#    --locked=false \
#    --description docker-stable \
#    --url http://localhost:8929/ \
#    --executor docker \
#    --docker-image docker:stable \
#    --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
#    --docker-network-mode gitlab-network
