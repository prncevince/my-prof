if [ -n "$ZSH_VERSION" ]; then unsetopt local_options nomatch; fi
if [ -f .Rversion ]; then 
  rpath=/Library/Frameworks/R.framework/Versions
  old=$(/usr/bin/readlink "$rpath"/Current); 
  ver=$(/bin/cat .Rversion)
  rpaths=$(/bin/ls "$rpath" | /usr/bin/grep "$ver")
  if [[ -z "$rpaths" ]]; then 
    echo "R version" "$new" "not installed" && exit;
  else
    if [[ -n $(/usr/sbin/sysctl -n machdep.cpu.brand_string | /usr/bin/grep -o "Apple") ]]; then
      arm=1
      ver_arm=$(echo "$rpaths" | /usr/bin/grep "arm")
    fi
    if [[ "$arm" == 1 && -n "$ver_arm" ]]; then
      new=$ver_arm
    else
      new=$ver
    fi
    if [[ "$new" != "$old" ]]; then
      /bin/ln -sfh "$new" "$rpath"/Current
      ({ sleep 5; /bin/ln -sfh "$old" "$rpath"/Current;} &)
    fi
  fi
fi
if [ -f *.Rproj ]; then 
  /usr/bin/open -na RStudio *.Rproj
else 
  ("/Applications/RStudio.app/Contents/MacOS/RStudio" &)
fi
