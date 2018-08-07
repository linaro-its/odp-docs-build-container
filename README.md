# odp-docs-build-container
A Docker container used by Linaro's web-site build process.

The container isolates the building of the ODP documentation for the ODP site. This avoids needing to install directly on the host the numerous packages used when building the documentation. It also makes it more self-documenting in terms of the packages needed to build the documentation.

Build the container in the usual way, e.g.

`docker build --rm -t "linaroits/odpdocsbuild:latest" .`

A number of scripts are stored in the container to simplify the rebuilding of the ODP documentation. For each command, a folder on the host needs to be passed in order to (a) provide a place on the host for the built documentation to be stored and (b) to provide a stateful location for repositories to be stored.

## Rebuilding gitstats pages
The gitstats pages are rebuilt with:

`docker run --rm -it -v <workspace>:/srv/odp-workspace linaroits/odpdocsbuild bash /srv/bamboo-task-scripts/rebuild-gitstats.sh`

where `workspace` is the path to a folder on the host used as a scratch space for repos and output.

## Rebuilding documentation pages
The documentation pages are rebuilt with:

`docker run --rm -it -v <workspace>:/srv/odp-workspace linaroits/odpdocsbuild bash /srv/bamboo-task-scripts/rebuild-documentation.sh`

where `workspace` is the path to a folder on the host used as a scratch space for repos and output.

## Rebuilding API diff pages
The API diff pages are rebuilt with:

`docker run --rm -it -v <workspace>:/srv/odp-workspace linaroits/odpdocsbuild bash /srv/bamboo-task-scripts/rebuild-diffs.sh`

where `workspace` is the path to a folder on the host used as a scratch space for repos and output.
