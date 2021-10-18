#!/bin/bash
set -e
source /opt/conda/etc/profile.d/conda.sh
source /etc/bsui/default_vars
# $BS_ENV and/or $BS_PROFILE may be overridden in .bashrc to load custom/local environment
#    or load startup files from a different IPython profile. This behavior is consistent with BSUI.
source ~/.bashrc
conda activate $BS_ENV
start-re-manager --startup-profile $BS_PROFILE --redis-addr {{ redis_addr }} --zmq-publish-console ON --console-output OFF --keep-re
