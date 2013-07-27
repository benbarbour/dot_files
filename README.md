My Environment
==============

Description
-----------
Various configuration files, vim plugins, and misc scripts.

Comes with a little script I use to symlink everything in place. You may or may
not want to run it... chances are you like things a little different than I do.

This repo is primarily for me to sync my stuff around, but others may find some config
useful, I guess.


Install Prequisites
-------------------
To make your environment exactly like mine you should install these items first:

1. [The Silver Searcher](https://github.com/ggreer/the\_silver\_searcher#building-from-source)
2. sudo pip install pylama prettytable
3. sudo apt-get install vim tmux
4. sudo apt-get install vim-ruby
   (for vim plugin LustyJuggler - you may have to get this from a virtual package such
   as vim-gnome)

*Note: There might be more to install - if you find anything let me know and
I'll add it here*

Alternatively, you can now pass the -i/--install option to `setup_bbenv.py`
to run commands 2-3, and install the neobundle vim plugin, but you must run with
`sudo`.


Install config files and scripts
--------------------------------
Then clone this repo into ~/.bbenv (or wherever you want)

Then run `setup_bbenv.py` to create all the nessecary symlinks (it will
prompt you with what it's going to create, so you can cancel if needed)

*If you cloned to a location other than ~/.bbenv then pass the `-r /clone/location`
to setup_bbenv.py*


Install vim plugins
-------------------
1. git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
2. Open vim and run :NeoBundleInstall to install all my vim plugins

Finally, close and open vim again.


Install the support for powerline fonts
=======================================
Follow the instructions for linux at: https://powerline.readthedocs.org/en/latest/installation/linux.html

On Ubuntu 13.04, I used the FontConfig method, putting `10-powerline-symbols.conf` into
`~/.config/fontconfig/conf.d/`, and it worked fine.
