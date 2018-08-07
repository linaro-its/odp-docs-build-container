# For building the ODP documentation

# Set the base image to Ubuntu (version 18.04)
# Uses the new "ubuntu-minimal" image
# Should be Alpine like all the cool kids, but
FROM ubuntu:18.04

# File Authors / Maintainers
# Initial Maintainer
LABEL maintainer="philip.colmer@linaro.org"

################################################################################
# Basic APT commands
# Tell apt not to use interactive prompts
RUN export DEBIAN_FRONTEND=noninteractive && \
# Clean package cache and upgrade all installed packages
	apt-get clean \
# No confirmation
	-y && \
	apt-get update && \
	apt-get upgrade -y && \
# Clean up package cache in this layer
	apt-get --purge autoremove -y && \
	apt-get clean -y && \
# Restore interactive prompts
	unset DEBIAN_FRONTEND
################################################################################

################################################################################
# Install latest software
# Change the date time stamp if you want to rebuild the image from this point down
# Useful for Dockerfile development
ENV SOFTWARE_UPDATED 2018-08-07.1422

# Install packages
# Add update && upgrade to this layer in case we're rebuilding from here down
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
	sudo \
    automake \
    autoconf \
    libtool \
    pkg-config \
    libssl-dev \
    mscgen \
    doxygen \
    graphviz \
    asciidoctor \
    source-highlight \
    librsvg2-bin \
    autotools-dev \
    pandoc \
    libcunit1-dev \
    git \
	python \
	gnuplot \
	libconfig-dev \
	&& \
	apt-get --purge autoremove -y && \
	apt-get clean -y
################################################################################

################################################################################
# Add update && upgrade to this layer in case we're rebuilding
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get --purge autoremove -y && \
	apt-get clean -y
################################################################################

################################################################################
# Dockerfile development only
ENV CONFIG_UPDATED 2018-08-07.1422
################################################################################

WORKDIR /srv

COPY odp-gitstats.sh /srv/bamboo-task-scripts/odp-gitstats.sh
COPY odp-documentation.sh /srv/bamboo-task-scripts/odp-documentation.sh
COPY odp-diff-abi-api-publish.sh /srv/bamboo-task-scripts/odp-diff-abi-api-publish.sh
COPY rebuild-gitstats.sh /srv/bamboo-task-scripts/rebuild-gitstats.sh
COPY rebuild-documentation.sh /srv/bamboo-task-scripts/rebuild-documentation.sh
COPY rebuild-diffs.sh /srv/bamboo-task-scripts/rebuild-diffs.sh
COPY changelog-asciidoc.md /srv/bamboo-task-scripts/changelog-asciidoc.md

RUN git clone https://github.com/ohdarling/gitstats.git /srv/gitstats

RUN git clone --depth 1 git://git.linaro.org/lng/check-odp.git
RUN bash ./check-odp/pre-install.sh
RUN rm -r ./check-odp

CMD /bin/bash
