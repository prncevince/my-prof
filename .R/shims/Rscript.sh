#! /usr/bin/env sh
if [ -f .Rversion ]; then
  rpath=/Library/Frameworks/R.framework/Versions
  ver=$(/bin/cat .Rversion)
  if [[ $(/bin/ls "$rpath" | /usr/bin/grep "$ver") == "" ]]; then
    echo "R version" "$ver" "not installed" && exit
  else
    export R_HOME="$rpath"/"$ver"/Resources
  fi
  exec "$R_HOME"/Rscript "$@"
else
  exec /usr/local/bin/Rscript "$@"
fi
