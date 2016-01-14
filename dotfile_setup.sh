#!/bin/sh

### Create symlinks to dotfiles and config dirs

## Dotfile list
files="
  .bashrc
  .inputrc
  .gitconfig"

## Configuration directories list
confdirs="redshift"

## Locations we are dealing with
dotdir="$(dirname $0)"
homedir="$HOME"
confdir="${homedir}/.config"
backupdir="${homedir}/.dotfile_old

echo "${dotdir} $homedir $confdir"

## Create symlinks for dotfile, back up old ones in process
echo "Creating symlinks for dotfile, backing up old ones in ${backupdir}..."
mkdir -p $backupdir
for file in $files
do
  echo "Backing up ${file}"
  mv -i "${homedir}/${file}" "$backupdir"
  echo "Creating symlink for ${file} \n"
  ln -s "${dotdir}/${file}" "${homedir}/${file}"
done

## Create symlinks for config dirs, back up old ones in process
echo "Creating symlinks for config directories, backing up old ones in ${backupdir}..."
for confdir in $confdirs
do
  echo "Backing up ${confdir}"
  mv -i "${homedir}/${confdir}" "$backupdir"
  echo "Creating symlink for ${confdir} \n"
  ln -s "${dotdir}/${confdir}" "${homedir}/${confdir}"
done

echo "Dotfile setup complete."
