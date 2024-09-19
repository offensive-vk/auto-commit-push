#!/bin/bash

# Get the inputs from the action.yml file
NAME=${INPUT_NAME:-${GITHUB_REPOSITORY_OWNER}}
EMAIL=${INPUT_EMAIL:-"${GITHUB_ACTOR}@users.noreply.github.com"}
MESSAGE=${INPUT_MESSAGE:-"Auto Commit was Pushed by Actions."}
BRANCH=${INPUT_BRANCH:-${GITHUB_HEAD_REF}}
REPO=${GITHUB_REPOSITORY}
GITHUB_TOKEN=${INPUT_GITHUB_TOKEN:-${GITHUB_TOKEN}}
CO_AUTHORS=${INPUT_CO_AUTHORS:-""}

# Check if required inputs are provided
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN is required"
  exit 1
fi

if [ -z "$NAME" ]; then
  echo "Error: NAME is required"
fi

if [ -z "$EMAIL" ]; then
  echo "Error: EMAIL is required"
fi

if [ -z "$NAME" ]; then
  git config --global user.name "github-actions[bot]"
  git config --global user.email "github-actions[bot]@users.noreply.github.com"
else
  git config --global user.name "$NAME"
  git config --global user.email "$EMAIL"
fi

# Add safe directory config
git config --global --add safe.directory /github/workspace

# Stage all changes
git fetch --all
git pull --all --verbose
git add .

# Commit the changes
git commit -m "$MESSAGE"

# Push the changes to the specified branch
git push

# If the push is successful, print a success message
if [ $? -eq 0 ]; then
  echo "Changes pushed successfully to $REPO"
else
  echo "Failed to push changes to $REPO"
  exit 1
fi
