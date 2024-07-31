py_ver=3.11
header "INSTALL PYTHON $py_ver"
if ! command -v "python$py_ver"; then
	sudo add-apt-repository -y ppa:deadsnakes/ppa
	sudo apt-get -y update
	sudo apt-get -y install python$py_ver python$py_ver-dev
fi

python3.11 -m pip install argcomplete

header "INSTALL PIPX"
# see https://github.com/pypa/pipx/issues/1481
if ! command -v pipx; then
	sudo apt-get -y install pipx                   # installs pipx to /usr/local/bin
	pipx ensurepath                                # adds ~/.local/bin to path
	pipx install pipx                              # installs latest pipx to ~/.local/bin
	sudo apt-get purge -y --autoremove pipx        # remove pipx via apt, and all extra files including autocomplete from /usr/local/bin
	hash -r                                        # pick up the new path
	sudo ~/.local/bin/pipx install --global pipx   # installs latest pipx version to /usr/local/bin because --global works.
	pipx uninstall pipx                            # remove the local version
	pipx ensurepath                                # make sure the ~/.local/bin is added to $PATH
	sudo pipx --global ensurepath                  # make sure that /usr/local/bin is set to global install
else
	sudo pipx upgrade --global pipx
fi
