#! /usr/bin/env sh
quarto_dotfile_root() {
  Rscript -e "
    dotfile <- '.quarto-version' \n
    criterion <- rprojroot::root_criterion(
      function(path) file.exists(file.path(path, dotfile)), paste0('has ', dotfile)
    ) \n
    root <- tryCatch(rprojroot::find_root(criterion = criterion, path = '.'), error = function(e){}) \n
    cat(root)
  "
}
QUARTO_DOTFILE_ROOT=$(quarto_dotfile_root)
QUARTO_DOTFILE_PATH=$QUARTO_DOTFILE_ROOT/.quarto-version
if [ -f "$QUARTO_DOTFILE_PATH" ]; then
  QUARTOPATH=$QUARTO_DOTFILE_ROOT/.quarto-cli/
  QUARTO_VERSION=$(/bin/cat "$QUARTO_DOTFILE_PATH")
  QUARTO_PATHS=$(/bin/ls "$QUARTOPATH" | /usr/bin/grep "$QUARTO_VERSION")
  if [[ -z "$QUARTO_PATHS" ]]; then
    echo "Quarto version" "$QUARTO_VERSION" "not installed" && exit
  fi
  exec $QUARTOPATH/quarto-$QUARTO_VERSION-macos/bin/quarto "$@"
else
  exec /Applications/RStudio.app/Contents/Resources/app/quarto/bin/quarto "$@"
fi
