#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
METHOD_DIR="$(cd "${SCRIPT_DIR}" && pwd)"
cd "${METHOD_DIR}"

nextflow run Australian-Protein-Design-Initiative/nf-binder-design -params-file params.bindcraft.json -profile local -resume
