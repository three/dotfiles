#!/usr/bin/env python3
import argparse
import os
import re
import subprocess
import sys

def die(code, *args):
    if args:
        print(*args, file=sys.stderr)
    exit(code)

GIT_DEPENDENCIES=[
    ('nvm', 'https://github.com/nvm-sh/nvm.git'),
    ('oh-my-zsh', 'https://github.com/robbyrussell/oh-my-zsh.git'),
    ('powerlevel9k', 'https://github.com/bhilburn/powerlevel9k.git'),
    ('vim-plug', 'https://github.com/junegunn/vim-plug.git'),
    ('zsh-histdb', 'https://github.com/larkery/zsh-histdb.git'),
    ('zsh-autosuggestions', 'https://github.com/zsh-users/zsh-autosuggestions.git'),
]

def setup_deps():
    try:
        os.mkdir('./deps')
    except FileExistsError:
        pass

    submodule_revisions = []

    err = subprocess.call(['git', '--version'])
    if err != 0:
        die(err, "Failed to print git version (command not in PATH?)")

    for name, repo in GIT_DEPENDENCIES:
        clonepath = os.path.join('./deps', name)
        if not os.path.isdir(clonepath):
            err = subprocess.call(['git', 'clone', '--depth=1', repo, clonepath])
            if err != 0:
                die(err, "Unable to clone", name)
        err = subprocess.call(['git', '-C', clonepath, 'pull'])
        if err != 0:
            die(err, "Unable to pull", name)
        err = subprocess.call(
            ['git', '-C', clonepath, 'submodule', 'update', '--init', '--recursive']
        )
        if err != 0:
            die(err, "Unable to update submodules for", name)

        sp = subprocess.Popen(
            ['git', '-C', clonepath, 'rev-parse', 'HEAD'],
            stdout=subprocess.PIPE,
        )
        if sp.wait() != 0:
            die(err, "Unable to retrieve current revision for", name)
        current_revision = re.match(
            r'^([0-9a-f]+)\n$',
            sp.communicate()[0].decode('ascii'),
        ).groups()[0]
        submodule_revisions.append((name, current_revision))

    with open('deps_lock.txt', 'w+') as deps_lock:
        deps_lock.truncate(0)
        for name, rev in submodule_revisions:
            deps_lock.write(name)
            deps_lock.write(' ')
            deps_lock.write(rev)
            deps_lock.write('\n')

    print("Setup depdendencies successfully.")

def main():
    parser = argparse.ArgumentParser(
        prog="Dotfiles Setup",
        description="Setup Eric's dotfiles",
    )
    parser.add_argument(
        '--deps',
        action=argparse.BooleanOptionalAction,
    )
    args = parser.parse_args()

    print("== Dotfiles Setup ==")
    anything_done = False
    if args.deps:
        anything_done = True
        setup_deps()

    if not anything_done:
        print("Nothing was done.")
        exit(2)

if __name__ == '__main__':
    main()
