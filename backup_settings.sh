#!/bin/bash

# This script backs up and restores Ubuntu shortcuts and other settings

backup_folder=~/ubuntu-settings-backup

# Backup function
backup() {
  if [ -n "$2" ]; then
    backup_folder=$2
  fi
  mkdir -p $backup_folder
  cp -r ~/.config/dconf/user $backup_folder/dconf
  cp -r ~/.local/share/applications $backup_folder/applications
  echo "Ubuntu shortcuts and settings backed up to $backup_folder."
}

# Restore function
restore() {
  if [ -n "$2" ]; then
    backup_folder=$2
  fi
  cp -r $backup_folder/dconf ~/.config/dconf/
  cp -r $backup_folder/applications ~/.local/share/
  echo "Ubuntu shortcuts and settings restored from $backup_folder."
}

# Main function
main() {
  case "$1" in
    -b) backup "$@" ;;
    -r) restore "$@" ;;
    *) echo "Usage: $0 -b [-d directory_path] to backup or -r [-d directory_path] to restore." ;;
  esac
}

main "$@"
