#!/bin/bash

set -eou pipefail

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

# in case it's running already
vagrant destroy -f

# start the VM
vagrant up --provider virtualbox

###################
# Check that all roles are invoked
###################


