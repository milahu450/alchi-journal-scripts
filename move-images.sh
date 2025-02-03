#!/usr/bin/env bash

# run this after scan-adf.sh
# TODO maybe integrate this into scan-adf.sh



find . -mindepth 1 -maxdepth 1 -type f \
  -regextype posix-extended -regex \
  '\./[0-9]{4}-?[0-9]{2}-?[0-9]{2}[\._][0-9]{2}-?[0-9]{2}.*\.webp' -printf '%P\n' |
while read webp_path
do

  year_month=$(echo "$webp_path" |
    sed -E 's/^([0-9]{4}-?[0-9]{2})-?.*$/\1/')

  if [[ "$year_month" == "$webp_path" ]]; then
    echo "error: failed to parse year_month from webp_path: $webp_path"
    exit 1
  fi

  if [ ${#year_month} == 6 ]; then
    year_month=${year_month:0:4}-${year_month:4:2}
  fi

  #echo "$year_month $webp_path"

  mkdir -p "img/$year_month"

  base="$(basename "$webp_path")"

  if echo "$base" | grep -q -E '^[0-9]{4}[0-9]{2}[0-9]{2}_[0-9]{2}[0-9]{2}.*\.webp'; then
    base=$(echo "$base" |
      sed -E 's/^([0-9]{4})([0-9]{2})([0-9]{2})_([0-9]{2})([0-9]{2})/\1-\2-\3.\4-\5/'
    )
  fi

  output_path="img/$year_month/$base"

  if [[ -e "$output_path" ]]; then
    echo "error: output file exists: $output_path"
    exit 1
  fi

  mv "$webp_path" "$output_path"

  # fix: files on sdcard have mode 0777
  chmod 0644 "$output_path"

done
