#!/bin/bash
set -e

## Detect if helix is already installed
if command -v helix &>/dev/null; then
  echo "Helix is already installed."
  exit 0
fi

## Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_ID=$ID
    OS_ID_LIKE=$ID_LIKE
else
    echo "Cannot detect OS."
    exit 1
fi

install_helix_debian() {
    ## Download latest .deb release from GitHub
    TMP_DEB="$(mktemp)" &&
    
    wget -O "$TMP_DEB" "https://github.com/helix-editor/helix/releases/latest/download/helix-amd64.deb"
    
    sudo dpkg -i "$TMP_DEB"
    
    rm -f "$TMP_DEB"
}

install_helix_ubuntu() {
    sudo add-apt-repository ppa:maveonair/helix-editor -y
    sudo apt update
    sudo apt install helix -y
}

install_helix_fedora() {
    sudo dnf install helix -y
}

echo "Helix is not installed. Installing for OS: $OS_ID"
if [[ "$OS_ID" == "ubuntu" ]]; then
    install_helix_ubuntu
elif [[ "$OS_ID" == "debian" ]]; then
    install_helix_debian
elif [[ "$OS_ID" == "fedora" ]]; then
    install_helix_fedora
elif [[ "$OS_ID_LIKE" == *"debian"* ]]; then
    install_helix_debian
elif [[ "$OS_ID_LIKE" == *"rhel"* ]] || [[ "$OS_ID_LIKE" == *"fedora"* ]]; then
    install_helix_fedora
else
    echo "Unsupported or undetected Linux distribution."
    exit 1
fi
