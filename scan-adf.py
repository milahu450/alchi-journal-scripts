#! /usr/bin/env python3

# batch scan with Brother ADS-3000N
# based on scan-adf.sh

# todo use code from
# https://pypi.org/project/scan-to-paperless/
# https://pypi.org/project/adf2pdf/

# todo is there scanimage.exe for microsoft windows?

import os, sys, re, subprocess

args = [
  "scanimage",
  # todo
]

p = subprocess.Popen(args)

# todo
