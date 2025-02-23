#!/usr/bin/env bash

# run this after scan-adf.sh
# TODO maybe integrate this into scan-adf.sh


dirs=(
  # alchi-journal
  .
  # android camera
  /storage/emulated/0/DCIM/Camera/small/
  /storage/sdcard0/DCIM/Camera/small/
)


find "${dirs[@]}" -mindepth 1 -maxdepth 1 -type f \
  -regextype posix-extended -regex \
  '.*/(IMG_)?[0-9]{4}-?[0-9]{2}-?[0-9]{2}[\._]?[0-9]{2}-?[0-9]{2}.*\.webp' \
  -printf '%p\n' |
while read webp_path
do

#  echo
  echo "webp_path $webp_path"
# continue

  base="$(basename "$webp_path")"

  year_month=$(echo "$base" |
    sed -E 's/^(IMG_)?([0-9]{4}-?[0-9]{2})-?.*$/\2/')

  if [[ "$year_month" == "$base" ]]; then
    echo "error: failed to parse year_month from webp_path: $webp_path"
    exit 1
  fi

  # YYYYmmdd
  if [ ${#year_month} == 6 ]; then
    year_month=${year_month:0:4}-${year_month:4:2}
  fi

  # IMG_YYYYmmdd
  if [ ${#year_month} == 10 ]; then
    year_month=${year_month:4:4}-${year_month:8:2}
  fi

  echo "$year_month $webp_path"

  mkdir -p "img/$year_month"

  if echo "$base" | grep -q -E '^(IMG_)?[0-9]{4}[0-9]{2}[0-9]{2}_[0-9]{2}[0-9]{2}.*\.webp'; then
    base=$(echo "$base" |
      sed -E 's/^(IMG_)?([0-9]{4})([0-9]{2})([0-9]{2})_([0-9]{2})([0-9]{2})/\2-\3-\4.\5-\6/'
    )
  fi

  output_path="img/$year_month/$base"

  if [[ -e "$output_path" ]]; then
    echo "error: output file exists: $output_path"
    exit 1
  fi

  # debug: stop after first
  # break
# echo mv "$webp_path" "$output_path"
# continue

  mv "$webp_path" "$output_path"

  # fix: files on sdcard have mode 0777
  chmod 0644 "$output_path"

# break

done
