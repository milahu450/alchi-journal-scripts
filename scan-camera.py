#! /usr/bin/env python3

# batch scan with smartphone camera
# only compress images from 2MB to 0.1MB

# todo: deskew, crop, dynamic levels

# todo use code from
# https://pypi.org/project/scan-to-paperless/
# https://pypi.org/project/adf2pdf/

import os, sys, re, subprocess, shlex

sdcard_dir = "/storage/sdcard0"
camera_dir = sdcard_dir + "/DCIM/Camera"
alchi_dir = sdcard_dir + "/alchi"
journal_dir = alchi_dir + "/journal"
todo_dir = journal_dir + "/todo"

assert os.path.exists(camera_dir)
assert os.path.exists(journal_dir)

os.makedirs(todo_dir, exist_ok=True)
# os.makedirs(odir + "/deskew", exist_ok=True)

def run(*args, **kwargs):
  print("> " + shlex.join(args))
  subprocess.run(args, **kwargs)

for name in os.listdir(camera_dir):
  base, ext = os.path.splitext(name)
  path = camera_dir + "/" + name
  print(fpath)
  # no. deskew fails to crop images
  #;opath = odir + "/deskew/" + fname
  out = todo_dir + "/" + name
  
  run(
    "convert",
    fpath,
  )
  
sys.exit()

args = [
  "scanimage",
  # todo
]

p = subprocess.Popen(args)

# todo
