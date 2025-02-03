#!/usr/bin/env python3

import os
import subprocess
import glob

# Create the small directory if it doesn't exist
os.makedirs('small', exist_ok=True)

# ImageMagick options
bth = 40
wth = 98
quality = 80
small_scale = '50%'
extra_convert_options = []

# Shared convert options
shared_convert_options = [
    *extra_convert_options,
    '-set', 'colorspace', 'RGB',
    '+profile', '*',
    '-quality', str(quality),
    '-define', 'webp:lossless=false',
    '-define', 'webp:auto-filter=true',
    '-define', 'webp:image-hint=graph'
]

# Large image convert options
large_convert_options = shared_convert_options

small_convert_options = shared_convert_options + ['-scale', small_scale]

# Loop through all .jpg and .jpeg files
for file_path in glob.glob('*.jpg') + glob.glob('*.jpeg'):
    webp_small = f"small/{os.path.splitext(os.path.basename(file_path))[0]}.webp"

    # Skip if the file already exists
    if os.path.exists(webp_small):
        continue

    # Log the action
    print(f"Writing {webp_small}")

    # Call ImageMagick's convert command
    subprocess.run(['convert', file_path] + small_convert_options + [webp_small])
