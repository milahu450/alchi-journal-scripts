#!/usr/bin/env bash

set -eux

shopt -s nullglob

cd "$(dirname "$0")"/..

# if [ "$0" != "./scripts/add-images.sh" ]; then
if ! [ -e "scripts/add-images.sh" ]; then
if false; then
  echo "error: you must run this as"
  echo "  ./scripts/add-images.sh"
  echo "  from the alchi-journal repo"
  exit 1
fi

./scripts/move-images.sh

./scripts/generate-index-files.sh

git add img/*/*.webp
git add html/????-??.html
git add index.html || true
git add ????-??.md

git commit -m "add images"

git status
