#!/bin/sh

### Create symlinks to dotfiles and config dirs

## Dotfile list
files="
  bashrc
  zshrc
  inputrc
  gitconfig
  bash_profile"

## Locations we are dealing with
dotdir="$(readlink -f $(dirname $0))"
homedir="$HOME"
#confdir="${homedir}/.config"
backupdir="${homedir}/.dotfile_old"


## Create symlinks for dotfile, back up old ones in process
echo "Creating symlinks for dotfile, backing up old ones in ${backupdir}..."
mkdir -p $backupdir
for file in $files
do
  echo "Backing up ${file}"
  mv -i "${homedir}/.${file}" "$backupdir/${file}.$(date +%Y.%m.%d_%T)"
  echo "Creating symlink for ${file} \n"
  ln -s "${dotdir}/${file}" "${homedir}/.${file}"
done

## Create symlinks for config dirs, back up old ones in process
# echo "Creating symlinks for config directories, backing up old ones in ${backupdir}..."
# for dir in $confdirs
# do
#   echo "Backing up ${dir}"
#   mv -i "${confdir}/${dir}" "$backupdir"
#   echo "Creating symlink for ${dir} \n"
#   ln -s "${dotdir}/${dir}" "${confdir}/${dir}"
# done

echo "Dotfile setup complete."
