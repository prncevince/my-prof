#! /usr/bin/env sh
if [ -f .quarto-version ]; then
  QUARTOPATH=./.quarto-cli/
  QUARTO_VERSION=$(/bin/cat .quarto-version)
  QUARTO_PATHS=$(/bin/ls "$QUARTOPATH" | /usr/bin/grep "$QUARTO_VERSION")
  if [[ -z "$QUARTO_PATHS" ]]; then
    echo "Quarto version" "$QUARTO_VERSION" "not installed" && exit
  fi
  exec $QUARTOPATH/quarto-$QUARTO_VERSION-macos/bin/quarto "$@"
else
  exec /Applications/RStudio.app/Contents/Resources/app/quarto/bin/quarto "$@"
fi
