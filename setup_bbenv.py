#!/usr/bin/python
import os
import sys
import argparse
import subprocess

from collections import namedtuple

HOME = os.path.expanduser("~")


def prompt(prompt):
    val = None
    print("\n" + prompt + ":")
    try:
        val = raw_input().strip()
    except (EOFError, KeyboardInterrupt):
        print()
        pass
    return val
    namedtuple


def parse_args():
    parser = argparse.ArgumentParser(
        description='Set up the bbenv')
    parser.add_argument(
        '-r', '--root',
        default=HOME + '/.bbenv/',
        help=('The path to the bbenv checkout. (default: "~/.bbenv/)"')
    )
    parser.add_argument(
        '-i', '--install',
        action='store_true',
        default=False,
        help='The path to the bbenv checkout. (default: "~/.bbenv/)"')
    return parser.parse_args()

# ======== SCRIPT START =========

args = parse_args()

os.chdir(HOME)

if args.install:
    subprocess.call(
        'apt-get --ignore-missing install '
        'zsh meld tmux python-pip exuberant-ctags silversearcher-ag',
        shell=True)
    subprocess.call(
        'chsh -s $(which zsh)',
        shell=True)
    subprocess.call(
        'pip install flake8 prettytable virtualenvwrapper',
        shell=True)
    subprocess.call(
        'pip install git+git://github.com/Lokaltog/powerline',
        shell=True)

# Symlink dot files
excluded = (
    "README.md",
    "config",
    ".git",
    ".gitignore",
    "oh-my-zsh",
    os.path.basename(__file__),
)
Symlink = namedtuple('Symlink', ('src', 'target'))
symlinks = []
for dotfile in os.listdir(args.root):
    new_path = os.path.join(HOME, '.' + dotfile)
    if not dotfile in excluded:
        dotfile = os.path.join(args.root, dotfile)
        link = Symlink(dotfile, new_path)
        symlinks.append(link)

# Link config subdirs
baseDir = os.path.join(args.root, 'config')
for f in os.listdir(baseDir):
    new_path = os.path.join(HOME, '.config', f)
    f = os.path.join(baseDir, f)
    link = Symlink(f, new_path)
    symlinks.append(link)

# Link oh-my-zsh custom subdir
baseDir = os.path.join(args.root, 'oh-my-zsh', 'custom')
for f in os.listdir(baseDir):
    new_path = os.path.join(HOME, '.oh-my-zsh', 'custom', f)
    f = os.path.join(baseDir, f)
    link = Symlink(f, new_path)
    symlinks.append(link)

for sym in symlinks:
    print("symlinking '{}' to '{}'".format(sym.src, sym.target))
if prompt('Are you sure you wish to continue? [y/N]') != 'y':
    sys.exit()

for sym in symlinks:
    try:
        os.symlink(sym.src, sym.target)
    except OSError:
        os.unlink(sym.target)
        os.symlink(sym.src, sym.target)

if args.install:
    print("Cloning NeoBundle...")
    subprocess.call(
        'git clone git://github.com/Shougo/neobundle.vim '
        '~/.vim/bundle/neobundle.vim',
        shell=True)
