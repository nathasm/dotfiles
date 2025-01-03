#!/bin/bash

if [ ! -d "$HOME/.config/lunarvim" ]; then
   echo "Getting LunarVim"
   bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/master/utils/installer/install.sh)
else
   echo ".config/lunarvim already found, skipping."
fi
