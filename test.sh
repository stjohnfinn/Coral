#!/bin/bash

set -eou pipefail

red() {
  echo -e "\033[31m$@\033[0m"  # Red
}

yellow() {
  echo -e "\033[33m$@\033[0m"  # Yellow
}

green() {
  echo -e "\033[32m$@\033[0m"  # Green
}

################################################################################
# test.sh
#
#   This file contains a few tests that should be run to test any change. This 
# script should pass before merging always.
# TODO: implement that requirement for real in GitHub
# TODO: implement the equivalent of feature flags in this script so I can 
#   target certain tests

###################
# Start the Vagrant environment and then run the ansible
###################

echo "TEST 1: Provisioning"

# in case it's running already
vagrant destroy -f

# start the VM
vagrant up --provider virtualbox

# check status
if [ $? -eq 0 ]; then
  green "Provisioning succeeded. PASS"
else
  red "Provisioning failed."
  exit 1
fi

###################
# Check that all roles are invoked
###################

echo "TEST 2: Compare invoked roles to existing roles"

playbook_file="playbook.yml"

# get a list of roles
existing_roles=$(ls -d roles/*/ | xargs -n 1 basename | sort)

# get a list of invoked roles
invoked_roles=$(yq '.[0].roles[]' "$playbook_file" | sort)

# check for equality
if [ "$invoked_roles" = "$existing_roles" ]; then
  green "Invoked roles matches existing roles. PASS"
else
  red "Invoked roles does not match existing roles."
  exit 1
fi

green "All tests passed!"
