#!/usr/bin/env bash

# Define LSP install commands for each tool
npm_lsps=(
    "npm install -g @ansible/ansible-language-server"
    "npm install -g bash-language-server"
    "npm install -g vscode-langservers-extracted"
    "npm install -g dockerfile-language-server-nodejs"
    "npm install -g @microsoft/compose-language-service"
    "npm install -g pyright"
    "npm install -g sql-language-server"
    "npm install -g @tailwindcss/language-server"
    "npm install -g @vue/language-server"
    "npm install -g svelte-language-server"
    "npm install -g prettier"
    "npm install -g prettier-plugin-svelte"
    "npm install -g yaml-language-server@next"
    "npm install -g typescript typescript-language-server"
    "npm install -g intelephense"
)

go_lsps=(
    "go install golang.org/x/tools/gopls@latest"
    "go install github.com/go-delve/delve/cmd/dlv@latest"
    "go install golang.org/x/tools/cmd/goimports@latest"
    "go install github.com/nametake/golangci-lint-langserver@latest"
    "go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest"
    "go install github.com/grafana/jsonnet-language-server@latest"
)

pip_lsps=(
    "pip install --user ruff-lsp"
    "pip install --user ruff"
)

pipx_lsps=(
    "pipx install jedi-language-server"
    "pipx install python-lsp-server"
    "pipx inject python-lsp-server python-lsp-ruff python-lsp-black"
)

rustup_lsps=(
    "rustup component add rust-analyzer"
    "rustup component add rustfmt"
)

cargo_lsps=(
    "cargo install taplo-cli --locked --features lsp"
)

dotnet_lsps=(
    # OmniSharp requires manual installation: https://github.com/OmniSharp/omnisharp-roslyn/releases
    # Download and extract to ~/.local/bin/omnisharp or /usr/local/bin/omnisharp
)

tools=("npm" "go" "cargo" "rustup" "dotnet" "pip" "pipx")

# Check if each tool is installed
for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo -e "$tool is installed"
    else
        echo -e "$tool is NOT installed"
    fi
done

# Install LSPs with npm
if command -v npm >/dev/null 2>&1; then
    echo "Installing LSPs with npm"
    for lsp in "${npm_lsps[@]}"; do
        echo "Running: $lsp"
        $lsp || echo "Failed to install: $lsp"
    done
else
    echo "npm is not installed, skipping npm LSPs"
fi

# Install LSPs with go
if command -v go >/dev/null 2>&1; then
    echo "Installing LSPs with go"
    for lsp in "${go_lsps[@]}"; do
        echo "Running: $lsp"
        $lsp || echo "Failed to install: $lsp"
    done
else
    echo "go is not installed, skipping go LSPs"
fi

# Install LSPs with pip
if command -v pip >/dev/null 2>&1; then
    echo "Installing LSPs with pip"
    for lsp in "${pip_lsps[@]}"; do
        echo "Running: $lsp"
        $lsp || echo "Failed to install: $lsp"
    done
else
    echo "pip is not installed, skipping pip LSPs"
fi

# Install LSPs with pipx
if command -v pipx >/dev/null 2>&1; then
    echo "Installing LSPs with pipx"
    for lsp in "${pipx_lsps[@]}"; do
        echo "Running: $lsp"
        $lsp || echo "Failed to install: $lsp"
    done
else
    echo "pipx is not installed, skipping pipx LSPs"
fi

# Install LSPs with rustup
if command -v rustup >/dev/null 2>&1; then
    echo "Installing LSPs with rustup"
    for lsp in "${rustup_lsps[@]}"; do
        echo "Running: $lsp"
        $lsp || echo "Failed to install: $lsp"
    done
else
    echo "rustup is not installed, skipping rustup LSPs"
fi

# Install LSPs with cargo
if command -v cargo >/dev/null 2>&1; then
    echo "Installing LSPs with cargo"
    for lsp in "${cargo_lsps[@]}"; do
        echo "Running: $lsp"
        $lsp || echo "Failed to install: $lsp"
    done
else
    echo "cargo is not installed, skipping cargo LSPs"
fi

# Install LSPs with dotnet
if command -v dotnet >/dev/null 2>&1; then
    echo "Installing LSPs with dotnet"
    for lsp in "${dotnet_lsps[@]}"; do
        echo "Running: $lsp"
        $lsp || echo "Failed to install: $lsp"
    done
else
    echo "dotnet is not installed, skipping dotnet LSPs"
fi
