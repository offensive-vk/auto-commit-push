FROM ubuntu:24.04

RUN apt-get update && apt-get install -y git

COPY --chmod=755 *.sh /

ENTRYPOINT ["/bin/bash" , "/entrypoint.sh"]

LABEL \
    "name"="Auto Commit and Push Action" \
    "homepage"="https://github.com/marketplace/actions/auto-commit-push" \
    "repository"="https://github.com/offensive-vk/auto-commit-push" \
    "maintainer"="TheHamsterBot <TheHamsterBot@users.noreply.github.com>"