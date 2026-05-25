#!/bin/bash
# adapted for m3 HPC
# configured for scheduler execution
set -euo pipefail

# CHANGE THIS: path to your nf-binder-design clone
export WF_PATH="/fs04/scratch2/nx54/jmobbs/software/nf_binder/nf-binder-design/"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
METHOD_DIR="$(cd "${SCRIPT_DIR}" && pwd)"
cd "${METHOD_DIR}"

mkdir -p results/logs
DATESTAMP=$(date +%Y%m%d_%H%M%S)

# temp directories
export TMPDIR="/fs04/scratch2/nx54/jmobbs/tmp"
export NXF_TEMP="$TMPDIR"
export NXF_APPTAINER_TMPDIR="$TMPDIR"
mkdir -p "$TMPDIR"

# Apptainer container cache
export NXF_APPTAINER_CACHEDIR="/fs04/scratch2/nx54/jmobbs/software/tmp/apptainer/nxf_cache/"

# Optional module load for cluster environments
module load nextflow/24.04.3 || true

PARAMS_FILE="params.rfd.json"
if [[ "rfd" == "rfd" ]]; then
  if command -v envsubst >/dev/null 2>&1; then
    envsubst < "${PARAMS_FILE}" > "params_resolved.json"
    PARAMS_FILE="params_resolved.json"
  else
    echo "Warning: envsubst not found; using unresolved params file."
  fi
fi

nextflow \
  -c "${WF_PATH}/conf/platforms/m3.m3t007.config" run \
  "${WF_PATH}/main.nf" \
  -params-file "${PARAMS_FILE}" \
  -resume \
  -with-report "results/logs/report_rfd_${DATESTAMP}.html" \
  -with-trace "results/logs/trace_rfd_${DATESTAMP}.txt"
