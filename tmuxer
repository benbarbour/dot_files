#! /usr/bin/env python
from __future__ import print_function

import sys
import argparse
import subprocess
import prettytable
from collections import OrderedDict

# ===========DEFINITIONS=========== #
def prompt(prompt):
    val = None
    print("\n" + prompt)
    try:
        val = raw_input().strip()
    except (EOFError, KeyboardInterrupt):
        print()
        pass
    return val


class Window:

    def __init__(self, name, panes=1, layout='tiled'):
        self.name = name
        self.setLayout(layout)
        self.panes = panes

    def setLayout(self, layout):
        self._layout = layout if 'layout' else 'tiled'
        return self

    def create(self, session):
        subprocess.call(['tmux', 'new-window', '-n', self.name, '-t', session])
        self._create_panes()

    def _create_panes(self):
        for i in range(2, self.panes + 1):
            subprocess.call(['tmux', 'split-window'])
        if self.panes > 2:
            subprocess.call(['tmux', 'select-layout', self._layout])

WINDOW_SETS={
    'ftnt': [
        Window("FortiGate", panes=4, layout='tiled'),
        Window("Terminal"),
        Window("Code1", layout=''),
    ],
    'code': [
        Window("Terminal"),
        Window("Code1", panes=2, layout='main-vertical'),
    ],
}
INITAL_WINDOWS=[]


# ===========SCRIPT START=========== #

parser = argparse.ArgumentParser(
    description='Create a new, or attach to an existing, tmux session')
parser.add_argument('-w', '--window-set',
    help='Choose a Window Set')
opts = parser.parse_args()
winset = opts.window_set.lower() if opts.window_set else None
if winset in WINDOW_SETS:
   INITAL_WINDOWS = WINDOW_SETS[winset]

sessions = {}
try:
    output = subprocess.check_output([
        'tmux', 'ls', '-F',
        '#{session_name}:' +
        '#{session_attached} #{session_created_string}'
    ], stderr=subprocess.STDOUT)
    sessions = OrderedDict(
        [s.split(':', 1) for s in output.strip().splitlines()])
    for session, desc in sessions.items():
        fields = desc.split(' ', 1)
        sessions[session] = {'attached': fields[0],
                             'created': fields[1]}
except subprocess.CalledProcessError as e:
    pass

choice = None
if not sessions:
    print("No Existing Sessions")
    choice = prompt("Enter a new session name (blank to quit):")
else:
    tbl = prettytable.PrettyTable([
        "#", "Session Name", "Client Connected?", "Created Time"])
    i = 1
    for s, d in sessions.items():
        tbl.add_row([
            i, s,
            'y' if int(d['attached']) else 'n',
            d['created'],
        ])
        i += 1
    print(tbl)
    choice = prompt(
            "Enter a [new] session name (blank to quit) " +
            "or '#' and a session index (ie. #1)")


if not choice:
    sys.exit()

if len(choice) > 1 and sessions and choice[0] == '#':
    c = choice[1:]
    try:
        choice = int(c)
    except ValueError:
        pass

session = None
if isinstance(choice, int):
    if choice < 0 or choice > len(sessions):
        print("Invalid session number")
        sys.exit()
    else:
        session = sessions.keys()[choice - 1]
else:
    session = choice

# If the session doesn't exist, create it and add INITIAL_WINDOWS
if subprocess.call(['tmux', 'has', '-t', session], stderr=subprocess.PIPE) != 0:
    args = ['tmux', 'new', '-d', '-s', session]
    if len(INITAL_WINDOWS) > 0:
        w = INITAL_WINDOWS[0]
        args.extend(['-n', str(w.name)])
    subprocess.call(args)
    if len(INITAL_WINDOWS) > 0:
        w._create_panes()

    if len(INITAL_WINDOWS) > 0:
        for w in INITAL_WINDOWS[1:]:
            w.create(session)

subprocess.call(['tmux', 'attach', '-t', session])

