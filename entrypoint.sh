#!/bin/bash

# Get the inputs from the action.yml file
NAME=${INPUT_NAME:-${GITHUB_REPOSITORY_OWNER}}
EMAIL=${INPUT_EMAIL:-${GITHUB_REPOSITORY_OWNER_EMAIL}}
MESSAGE=${INPUT_MESSAGE:-"Auto Commit was Pushed by Actions."}
BRANCH=${INPUT_BRANCH:-${GITHUB_HEAD_REF}}
REPO=${GITHUB_REPOSITORY}
GITHUB_TOKEN=${INPUT_GITHUB_TOKEN:-${GITHUB_TOKEN}}
CO_AUTHORS=${INPUT_CO_AUTHORS:-""}

# Stage all changes
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git fetch --all
git pull --all --verbose
git add .

# Commit the changes with co-authors
git commit -m "$MESSAGE" --author "$NAME <$EMAIL> 

Co-authored-by: $(echo "$CO_AUTHORS" | sed 's/,/\ --co-author /g')"

# Set the GitHub token as an environment variable
export GITHUB_TOKEN=$GITHUB_TOKEN

# Push the changes to the specified branch
git push

# If the push is successful, print a success message
if [ $? -eq 0 ]; then
    echo "Changes pushed successfully to $REPO"
else
    echo "Failed to push changes to $REPO"
    exit 1
fi