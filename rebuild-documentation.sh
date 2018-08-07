#!/bin/bash
# This task builds the ODP documentation but leaves it for
# the "Build static opendataplane.org" project to copy it
# where it needs it.
#
# Fail as soon as one of these things fail ...
set -e
#
echo "Rebuilding master"
branch=master /srv/bamboo-task-scripts/odp-documentation.sh
echo "Rebuilding api-next"
branch=api-next /srv/bamboo-task-scripts/odp-documentation.sh
echo "Rebuilding monarch_lts"
branch=monarch_lts /srv/bamboo-task-scripts/odp-documentation.sh
#
# Build the rest of the documentation
echo "Building remaining documentation"
cd /srv/odp-workspace/odp
git checkout master
./bootstrap
./configure --enable-user-guides
make -C doc