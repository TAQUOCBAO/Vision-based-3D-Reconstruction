#!/usr/bin/env bash
set -euo pipefail

uv sync --extra deeplearning
PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 uv run pytest -q

