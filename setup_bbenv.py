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
    subprocess.call('pip install pylama', shell=True)
    subprocess.call('apt-get install tmux exuberant-ctags', shell=True)

excluded_dotfiles = (
    "README.md",
    os.path.basename(__file__),
)

# Symlink dot files
Symlink = namedtuple('Symlink', ('src', 'target'))
symlinks = []
for dotfile in os.listdir(args.root):
    new_path = os.path.join(HOME, '.' + dotfile)
    if not dotfile in excluded_dotfiles:
        dotfile = os.path.join(args.root, dotfile)
        print(dotfile)
        link = Symlink(dotfile, new_path)
        print(link)
        symlinks.append(link)

if prompt('Are you sure you wish to continue? [y/N]') != 'y':
    sys.exit()

for sym in symlinks:
    print("symlinking '{}' to '{}'".format(sym.src, sym.target))
    try:
        os.symlink(sym.src, sym.target)
    except OSError:
        os.unlink(sym.target)
        os.symlink(sym.src, sym.target)

if args.install:
    subprocess.call(
        'git clone git://github.com/Shougo/neobundle.vim '
        '~/.vim/bundle/neobundle.vim',
        shell=True)

subprocess.call("git config --global init.templatedir '~/.git_template'")
subprocess.call("git config --global alias.ctags '!.git/hooks/ctags'")
