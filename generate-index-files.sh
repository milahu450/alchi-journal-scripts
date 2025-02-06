#!/usr/bin/env bash

# FIXME font size is too small in tables

cd "$(dirname "$0")"/..

mkdir -p html

find img/ -mindepth 1 -maxdepth 1 -type d -regextype posix-extended -regex 'img/[0-9]{4}-[0-9]{2}' -printf '%P\n' |
sort |
while read month
do

  echo writing $month.md

  (
    printf '# %s\n\n' "$month"

    find img/$month/ -maxdepth 1 -name "$month-*.webp" |
    sort |
    while read f
    do
      n=${f##*/}
      md=${f%.*}.md
      printf '## %s\n\n' "$n"
      if [ -e "$md" ]; then
        printf "<blockquote>\n\n"
        cat "$md"
        printf "\n\n\n</blockquote>\n\n"
      fi
      printf '![](%s)\n\n' "$f"
    done
  ) >$month.md

  echo writing html/$month.html

  (
    printf '<h1>%s</h1>\n\n' "$month"

    find img/$month/ -maxdepth 1 -name "$month-*.webp" |
    sort |
    while read f
    do
      n=${f##*/}
      md=${f%.*}.md
      printf '<h2>%s</h2>\n\n' "$n"
      if [ -e "$md" ]; then
        printf "<blockquote>\n\n"
        pandoc -f markdown -t html "$md"
        printf "\n\n\n</blockquote>\n\n"
      fi
      printf '<img src="../%s">\n\n' "$f"
    done
  ) >html/$month.html

done

echo writing index.html

(
  find img/ -mindepth 1 -maxdepth 1 -type d -regextype posix-extended -regex 'img/[0-9]{4}-[0-9]{2}' -printf '%P\n' |
  sort |
  while read month
  do

    printf '<p><a href="html/%s.html">%s</a></p>\n\n' "$month" "$month"

  done
) >index.html
