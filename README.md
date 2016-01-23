My Environment
==============

Description
-----------
Various configuration files, vim plugins, and misc scripts.

Comes with a little script I use to symlink everything in place. You may or may
not want to run it... chances are you like things a little different than I do.

This repo is primarily for me to sync my stuff around, but others may find some
config useful, I guess.


Install
-------
First install neovim (v0.1.1) and tmux (2.2) - I did it from source.

Next, clone this repo into ~/.bbenv (or wherever you want)

To make your Ubuntu 15.10 environment exactly like mine you can run
`setup_bbenv.py -i`.

Then run `setup_bbenv.py` to create all the necessary symlinks (it will prompt
you with what it's going to create, so you can cancel if needed)

*If you cloned to a location other than ~/.bbenv then pass the `-r
/clone/location` to setup_bbenv.py*


Install nvim plugins
-------------------
1. Open nvim and run :PlugInstall

Finally, close and open nvim again.
