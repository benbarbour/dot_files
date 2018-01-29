My Environment
==============

Description
-----------
Various configuration files, neovim plugins, and misc scripts.

Comes with a little script I use to install common packages and then symlink
everything in place. You may or may not want to run it... chances are you like
things a little different than I do.

This repo is primarily for me to sync my stuff around, but others may find some
config useful, I guess.


Install
-------
Next, clone this repo into ~/.bbenv (or wherever you want)

To make your Ubuntu/Debian environment exactly like mine you can run
`cd ~/.bbenv && setup_bbenv.sh`.


Install nvim plugins
--------------------
Open nvim and run `:PlugUpgrade` and `:PlugInstall`


Optionally Logout
-----------------
If you changed shells from anything to zsh then you will need to logout and log
back in to use the new shell.
