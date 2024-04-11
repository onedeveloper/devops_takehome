#!/bin/bash

# Check if at least two arguments are provided
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <workspace> <terraform_command> [additional_args]"
  exit 1
fi

# Extract workspace and command from the arguments
WORKSPACE=$1
COMMAND=$2
shift 2 # Shift arguments to pass any additional arguments directly to Terraform

# Define the directories
STACK_DIR="stack"
ENV_DIR="env"

# Switch to the stack directory and select/create the workspace
(cd $STACK_DIR && terraform workspace select $WORKSPACE || terraform workspace new $WORKSPACE)

# Determine if the command is 'init', as it doesn't require variable files
if [ "$COMMAND" == "init" ]; then
  (cd $STACK_DIR && terraform "$COMMAND" "$@")
else
  # For other commands, use the corresponding environment-specific variable file
  VAR_FILE="../$ENV_DIR/${WORKSPACE}/${WORKSPACE}.auto.tfvars"
  if [ -f "$VAR_FILE" ]; then
    (cd $STACK_DIR && terraform "$COMMAND" -var-file="$VAR_FILE" "$@")
  else
    echo "Error: Variable file for workspace '$WORKSPACE' not found."
    exit 1
  fi
fi

