# Install Homebrew package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Use Homebrew to install tmux
brew install tmux

# Download a pre-made .tmux.conf NOTE: Need to make changes or weired key behavior will ensue
cd
$ git clone https://github.com/gpakosz/.tmux.git
$ ln -s -f .tmux/.tmux.conf
$ cp .tmux/.tmux.conf.local .
# In first line of settings change to:
# set -g default-terminal "xterm"
# Then:
# comment out the line:
# if 'infocmp -x tmux-256color > /dev/null 2>&1' 'set -g default-terminal "tmux-256color"'


# Setup vim on your own

# Install miniconda3 for either mac m1 or intel
mkdir -p ~/miniconda3
if [[ $(uname -m) == 'arm64']]; then
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda3/miniconda.sh
else
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda3/miniconda.sh

bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh

# Create conda environment with all the best ML tools
# If this is Apple silicon, numpy and tensorflow have specific install requirements
conda create -n ml python=3.9
conda activate ml
# Install numpy dependent on chipset
if [[ $(uname -m) == 'arm64']]; then
	conda install numpy “blas=*=*accelerate*”
else
	conda install numpy

conda install pytorch torchvision torchaudio -c pytorch # Install PyTorch

# Install tensorflow dependent on chipset
if [[ $(uname -m) == 'arm64']]; then
	conda install -c apple tensorflow-deps
	pip install tensorflow-macos
	pip install tensorflow-metal
else
	pip install tensorflow

conda install -c conda-forge matplotlib scikit-learn opencv pandas jupyterlab scipy
