#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_tentacle_learn info
PYTHONPATH=src python -m gbt_tentacle_learn check --payload '{}'
PYTHONPATH=src python -m gbt_tentacle_learn run   --payload '{}'
