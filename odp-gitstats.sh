#!/bin/bash
# shellcheck disable=SC2154
set -e
cd /srv/gitstats
git pull

cd /srv/odp-workspace
if [ -d "linux-${platform_type}-gitstats" ]; then
   rm -rf "linux-${platform_type}-gitstats"
fi
case "${platform_type}" in
   generic)
      repo_name=odp
      ;; 
   dpdk)
      repo_name=odp-dpdk
      ;;
esac
if [ -d ${repo_name} ]; then
   rm -rf ${repo_name}
fi
git clone git://git.linaro.org/lng/${repo_name}.git
cd ${repo_name}
/srv/gitstats/gitstats -c max_authors=50 -c merge_authors="mike-holmes,Mike Holmes" -c merge_authors="santosh shukla,Santosh Shukla" -c merge_authors="Yan Sonming,Yan Songming" -c merge_authors="venkatesh vivekanandan,Venkatesh Vivekanandan" . "../linux-${platform_type}-gitstats"
