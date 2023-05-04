#!/bin/bash
TOPDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
find $TOPDIR -type f -name "*.sh" -exec chmod -v u+x {} \;
