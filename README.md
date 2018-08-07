# odp-docs-build-container
A Docker container used by Linaro's web-site build process.

The container isolates the building of the ODP documentation for the ODP site. This avoids needing to install directly on the host the numerous packages used when building the documentation. It also makes it more self-documenting in terms of the packages needed to build the documentation.

Build the container in the usual way, e.g.

`docker build --rm -t "linaroits/odpdocsbuild:latest" .`

## Gitstats
The gitstats pages are rebuilt with:

`docker run --rm -it -v <workspace>:/srv/odp-workspace linaroits/odpdocsbuild bash /srv/bamboo-task-scripts/build-gitstats.sh`

where `workspace` is the path to a folder on the host used as a scratch space for repos and output.
