#!/usr/bin/env bash

set -x

git push github.com "$@"
git push righttoprivacy.onion "$@"

# darktea is broken since 2025-02-08
# git push darktea.onion "$@"
