#!/bin/sh

configure_block() {
  local file="$1" prefix="$2" subst="$3" tmpfile="$(mktemp)"
  local enable=$(printenv "${prefix}_ENABLED")
  local url=$(printenv "${prefix}_URL")
  local result=1

  if [ -z "$enable" ]; then
    echo "Disabling $prefix"
    sed -r "/${prefix}_BEGIN/,/${prefix}_END/d" $file > $tmpfile
  elif [ -z "$url" ]; then
    echo "Enabling $prefix"
    sed -r -e "/${prefix}_(BEGIN|END)/d" $file > $tmpfile
    result=0
  else
    echo "Enabling $prefix with URL"
    sed -r -e "s|${prefix}_URL|${url}|" -e "/${prefix}_(BEGIN|END)/d" $file > $tmpfile
    result=0
  fi
  cat "$tmpfile" > "$file"
  rm "$tmpfile"
  return $result
}

cd /usr/share/nginx/html

configure_block index.html "S3"
configure_block index.html "DASHBOARD"
configure_block index.html "UPLOAD_PORTAL"
configure_block index.html "REST_AUTHORIZER"

configure_block index.html "MONITOR"
has_monitor=$?
configure_block index.html "GRAYLOG"
has_graylog=$?

if [ $has_monitor = 0 ] || [ $has_graylog = 0 ]; then
  SYSTEM_ENABLED="1" configure_block index.html "SYSTEM"
else
  SYSTEM_ENABLED="" configure_block index.html "SYSTEM"
fi
