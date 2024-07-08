#!/bin/bash

# Update package list
apt update

# Install required packages
DEBIAN_FRONTEND=noninteractive apt install -y wget curl

# Create necessary directories
mkdir -p /workspace

# Install build dependencies
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  openssh-server \
  git \
  make \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  wget \
  curl \
  llvm \
  libncursesw5-dev \
  xz-utils \
  tk-dev \
  libxml2-dev \
  libxmlsec1-dev \
  libffi-dev \
  liblzma-dev

# Install pyenv
curl https://pyenv.run | bash

# Append pyenv settings to .bashrc
cat <<'EOF' >> ~/.bashrc
export PYENV_ROOT="\$HOME/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init --path)"
eval "\$(pyenv init -)"
EOF

# Create .ssh directory and set permissions
mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "$PUBLIC_KEY" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
service ssh start

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Append nvm settings to .bashrc
cat <<'EOF' >> ~/.bashrc
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

# Source nvm script directly to ensure it is available in the current shell session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Install Node.js and pm2
nvm install 20
npm i -g pm2

# Keep the container running
sleep infinity
