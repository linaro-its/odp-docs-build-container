#!/bin/bash
# shellcheck disable=SC2154
#
# From the original Jenkins shell script for the ABI and API builds.
set -e
cd /srv/odp-workspace
if [ -d check-odp ]; then
   rm -rf check-odp
fi
git clone --depth 1 git://git.linaro.org/lng/check-odp.git
./check-odp/pre-install.sh
if [ -d "${platform_type}" ]; then
   rm -rf "${platform_type}"
fi

# Following a discussion with Maxim, we don't run this script
# for DPDK, only generic.
#
#case "${platform_type}" in
#  dpdk)
#    mkdir -p ${HOME}/bin
#    cp check-odp/helper/ci-uname ${HOME}/bin/uname
#    export PATH=${HOME}/bin:${PATH}
#    export COMPARE_URL=git://git.linaro.org/lng/odp-dpdk.git
#    export COMPARE_BRANCH=master
#    ;;
#esac

bash -x ./check-odp/diff-abi.sh |tee
bash -x ./check-odp/diff-api.sh |tee

mkdir "${platform_type}"
mv check-odp/publishing/diff-abi "${platform_type}/"
mv check-odp/publishing/diff-api "${platform_type}/"
