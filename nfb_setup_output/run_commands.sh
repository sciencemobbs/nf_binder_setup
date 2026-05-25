#!/usr/bin/env bash
set -euo pipefail

bash "/home/jmobbs/code/nf_binder_project/nfb_setup_output/rfd/run_rfd_local.sh"
bash "/home/jmobbs/code/nf_binder_project/nfb_setup_output/bindcraft/run_bindcraft_local.sh"
bash "/home/jmobbs/code/nf_binder_project/nfb_setup_output/boltzgen/run_boltzgen_local.sh"
