#!/bin/bash

# Get the inputs from the action.yml file
NAME=${INPUT_NAME:-${GITHUB_REPOSITORY_OWNER}}
EMAIL=${INPUT_EMAIL:-${GITHUB_REPOSITORY_OWNER_EMAIL}}
MESSAGE=${INPUT_MESSAGE:-"Auto Commit was Pushed by Actions."}
BRANCH=${INPUT_BRANCH:-${GITHUB_HEAD_REF}}
REPO=${GITHUB_REPOSITORY}
GITHUB_TOKEN=${INPUT_GITHUB_TOKEN:-${GITHUB_TOKEN}}
CO_AUTHORS=${INPUT_CO_AUTHORS:-""}

# Check if required inputs are provided
if [ -z "$NAME" ]; then
  echo "Error: INPUT_NAME is required"
fi

if [ -z "$EMAIL" ]; then
  echo "Error: INPUT_EMAIL is required"
fi

if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: INPUT_GITHUB_TOKEN is required"
  exit 1
fi

# Stage all changes
git config --local user.name "$NAME"
git config --local user.email "$EMAIL"
git fetch --all
git pull --all --verbose
git add .

# Commit the changes with co-authors
git commit -m "$MESSAGE"

if [ -n "$CO_AUTHORS" ]; then
  echo "Co-authored-by: $(echo "$CO_AUTHORS" | sed 's/,/\ --co-author /g')"
fi

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