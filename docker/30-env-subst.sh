#!/bin/sh

set -e

configure_block() {
  local file="$1" prefix="$2" subst="$3" tmpfile="$(mktemp)"
  local enable=$(printenv "${prefix}_ENABLED")
  local subst_key="${prefix}_${subst}"
  local subst_value=""
  if [ -n "$enable" ] && [ -n "$subst" ]; then
    subst_value=$(printenv "$subst_key")
    if [ -z "$subst_value" ]; then
      enable=""
    fi
  fi

  if [ -z "$enable" ]; then
    echo "Disabling $prefix"
    sed -r "/${prefix}_BEGIN/,/${prefix}_END/d" $file > $tmpfile
  elif [ -n "$subst_value" ]; then
    echo "Enabling $prefix (including $subst)"
    sed -r "s|${subst_key}|${subst_value}|" $file | sed -r "/${prefix}_(BEGIN|END)/d" > $tmpfile
  else
    echo "Enabling $prefix"
    sed -r "/${prefix}_(BEGIN|END)/d" $file > $tmpfile
  fi
  cat "$tmpfile" > "$file"
  rm "$tmpfile"
}

cd /usr/share/nginx/html

configure_block index.html "S3" "URL"
configure_block index.html "DASHBOARD" "URL"
configure_block index.html "UPLOAD_PORTAL"
configure_block index.html "REST_AUTHORIZER"
