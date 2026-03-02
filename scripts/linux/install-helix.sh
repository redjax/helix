#!/usr/bin/env bash
set -e

## Detect if helix is already installed and check for updates
if command -v hx &>/dev/null; then
    INSTALLED_VERSION=$(hx --version | cut -d' ' -f2 | tr -d 'v')
    echo "Helix is installed (version: $INSTALLED_VERSION)."

    # Fetch latest release tag from GitHub API
    LATEST_VERSION=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//')

    if [[ "$INSTALLED_VERSION" == "$LATEST_VERSION" ]]; then
        echo "You have the latest version ($LATEST_VERSION)."
        exit 0
    else
        echo "Newer version available: $LATEST_VERSION (vs your $INSTALLED_VERSION)"
        read -p "Do you want to update Helix? (y/N): " -r UPDATE
        if [[ ! "$UPDATE" =~ ^[Yy]$ ]]; then
            echo "Update cancelled."
            exit 0
        fi
        echo "Proceeding with update..."
    fi
else
    echo "Helix is not installed. Installing latest version..."
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
    # Detect architecture and map to correct filename
    ARCH=$(uname -m)
    if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
        PKG="helix-25.07.1-aarch64-linux.tar.xz"
    elif [[ "$ARCH" == "armv7l" ]]; then
        echo "32-bit ARM not supported by prebuilt binaries. Use snap or compile from source."
        return 1
    else
        echo "Unsupported architecture: $ARCH"
        return 1
    fi

    echo "Downloading $PKG for $ARCH..."

    # Download specific version tarball
    TMP_TAR="$(mktemp)"
    wget -O "$TMP_TAR" "https://github.com/helix-editor/helix/releases/latest/download/$PKG" || {
        echo "Download failed. Trying direct version URL..."
        wget -O "$TMP_TAR" "https://github.com/helix-editor/helix/releases/download/25.07.1/$PKG"
    }

    if [[ ! -s "$TMP_TAR" ]]; then
        echo "Download failed - file empty or missing."
        rm -f "$TMP_TAR"
        return 1
    fi

    # Backup existing install if present
    if [ -d /opt/helix ]; then
        sudo mv /opt/helix /opt/helix.backup.$(date +%Y%m%d_%H%M%S)
    fi

    # Extract to /opt/helix
    sudo mkdir -p /opt/helix
    sudo tar -xJf "$TMP_TAR" -C /opt/helix --strip-components=1

    # Create symlink
    sudo ln -sf /opt/helix/hx /usr/local/bin/hx

    # Setup runtime (cleaner approach - symlink instead of copy)
    mkdir -p ~/.config/helix
    if [ ! -L ~/.config/helix/runtime ]; then
        ln -sf /opt/helix/runtime ~/.config/helix/runtime
    fi

    rm -f "$TMP_TAR"
    echo "Helix installed successfully. Run 'hx --version' to verify."
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
