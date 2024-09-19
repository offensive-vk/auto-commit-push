FROM ubuntu:24.04

RUN apt-get update && apt-get install -y git

# Copy the entrypoint.sh script to the Docker image root
COPY --chown=1000:1000 --chmod=+x entrypoint.sh /

# Set entrypoint to the script
ENTRYPOINT ["sh", "/entrypoint.sh"]

LABEL \
    "name"="Auto Commit and Push Action" \
    "homepage"="https://github.com/marketplace/actions/auto-commit-push" \
    "repository"="https://github.com/offensive-vk/auto-commit-push" \
    "maintainer"="TheHamsterBot <TheHamsterBot@users.noreply.github.com>"