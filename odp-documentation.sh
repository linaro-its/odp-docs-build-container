#!/bin/bash
# shellcheck disable=SC2154
set -e
# Set up the environment
if [ ! -d /srv/odp-workspace/odp ]; then
   git clone git://git.linaro.org/lng/odp.git /srv/odp-workspace/odp
fi
cd /srv/odp-workspace/odp
git checkout "${branch}"
git pull
./bootstrap
./configure --enable-user-guides
# Build the API documentation
make doxygen-doc
# and copy it somewhere sensible/safe ...
if [ ! -d ../api-documentation ]; then
   mkdir ../api-documentation
fi
if [ -d "../api-documentation/${branch}" ]; then
   rm -rf "../api-documentation/${branch}"
fi
mkdir -p "../api-documentation/${branch}/api"
cp -R doc/application-api-guide/output/html/* "../api-documentation/${branch}/api/"
mkdir -p "../api-documentation/${branch}/helper-guide"
cp -R doc/helper-guide/output/html/* "../api-documentation/${branch}/helper-guide/"
cat /srv/bamboo-task-scripts/changelog-asciidoc.md CHANGELOG > "../api-documentation/${branch}/changelog.adoc"
git reset --hard
# Make sure any untracked files are removed, ready for the next run
git clean -dfx