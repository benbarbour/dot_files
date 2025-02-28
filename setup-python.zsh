if [ ! -d "$HOME/.pyenv" ]; then
	curl -fsSL https://pyenv.run | bash

	sudo apt install -y \
		build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev curl git \
		libncursesw5-dev xz-utils tk-dev libxml2-dev \
		libxmlsec1-dev libffi-dev liblzma-dev
fi

pyenv install -s 3.13
pyenv global 3.13
