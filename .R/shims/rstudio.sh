rpath=/Library/Frameworks/R.framework/Versions
old=$(/usr/bin/readlink "$rpath"/Current); 
if [ -f .Rversion ]; then 
  new=$(/bin/cat .Rversion)
  if [[ $(/bin/ls "$rpath" | /usr/bin/grep "$new") == "" ]]; then 
    echo "R version" "$new" "not installed" && exit; else
    /bin/ln -sfh "$new" "$rpath"/Current; fi; fi
if [ -n "$ZSH_VERSION" ]; then unsetopt local_options nomatch; fi
if [ -f *.Rproj ]; then 
  (/usr/bin/open -na Rstudio . &) 
fi; ({ sleep 5; /bin/ln -sfh "$old" "$rpath"/Current;} &)
