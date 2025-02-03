#! /usr/bin/env python3

# batch scan with Brother ADS-3000N
# based on scan-adf.sh

# todo use code from
# https://pypi.org/project/scan-to-paperless/
# https://pypi.org/project/adf2pdf/

# todo is there scanimage.exe for microsoft windows?

# deskew
# https://github.com/galfar/deskew

import os, sys, re, subprocess, shlex

fdir = "/storage/sdcard0/DCIM/Camera"

odir = "/storage/sdcard0/Pictures/scan-camera"

os.makedirs(odir, exist_ok=True)
os.makedirs(odir+ "/deskew", exist_ok=True)

for fname in os.listdir(fdir):
  fpath = fdir + "/" + fname
  print(fpath)
  # no. deskew fails to crop images
  opath = odir + "/deskew/" + fname
  args = [
    "deskew",
    "-o", opath,
    fpath,
  ]
  print("> " + shlex.join(args))
  subprocess.run(args)

sys.exit()

args = [
  "scanimage",
  # todo
]

p = subprocess.Popen(args)

# todo
