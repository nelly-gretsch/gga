#!/usr/bin/env bash
set -euo pipefail

TEMPLATE_MSAPP=${1:-"Open Close.msapp"}
SRC_DIR=${2:-"msapp_src"}
OUT_MSAPP=${3:-"Open Close.msapp"}

if [[ ! -f "$TEMPLATE_MSAPP" ]]; then
  echo "Template msapp not found: $TEMPLATE_MSAPP" >&2
  exit 1
fi

if [[ ! -d "$SRC_DIR" ]]; then
  echo "Source directory not found: $SRC_DIR" >&2
  exit 1
fi

WORK_DIR=$(mktemp -d)
cleanup() {
  rm -rf "$WORK_DIR"
}
trap cleanup EXIT

unzip -q "$TEMPLATE_MSAPP" -d "$WORK_DIR"
rm -rf "$WORK_DIR/Src"
mkdir -p "$WORK_DIR/Src"
cp -R "$SRC_DIR"/*.pa.yaml "$WORK_DIR/Src/"

(
  cd "$WORK_DIR"
  zip -qr "$OUT_MSAPP" .
)

mv "$WORK_DIR/$OUT_MSAPP" "$OUT_MSAPP"

echo "Packaged $OUT_MSAPP from $SRC_DIR using $TEMPLATE_MSAPP"
