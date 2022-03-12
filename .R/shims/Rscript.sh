#! /usr/bin/env sh
if [ -f .Rversion ]; then
  rpath=/Library/Frameworks/R.framework/Versions
  ver=$(/bin/cat .Rversion)
  rpaths=$(/bin/ls "$rpath" | /usr/bin/grep "$ver")
  if [[ -z "$rpaths" ]]; then
    echo "R version" "$ver" "not installed" && exit
  else
    if [[ -n $(/usr/sbin/sysctl -n machdep.cpu.brand_string | /usr/bin/grep "Apple") ]]; then
      arm=1
      ver_arm=$(echo "$rpaths" | /usr/bin/grep "arm")
    fi
    if [[ "$arm" == 1 && -n "$ver_arm" ]]; then
      export R_HOME="$rpath"/"$ver"-arm64/Resources
    else
      export R_HOME="$rpath"/"$ver"/Resources
    fi
  fi
  exec "$R_HOME"/Rscript "$@"
else
  exec /usr/local/bin/Rscript "$@"
fi
