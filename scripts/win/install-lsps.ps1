## LSPs installable with npm
$NpmLsps = @(
    "npm i -g @ansible/ansible-language-server",
    "npm i -g bash-language-server",
    "npm i -g vscode-langservers-extracted",
    "npm install -g dockerfile-language-server-nodejs",
    "npm install -g @microsoft/compose-language-service",
    "npm install pyright -g",
    "npm i -g sql-language-server",
    "npm i -g @tailwindcss/language-server",
    "npm i -g @vue/language-server",
    "npm i -g svelte-language-server",
    "npm i -g prettier",
    "npm i -g prettier-plugin-svelte",
    "npm i -g yaml-language-server@next",
    "npm install -g typescript typescript-language-server",
    "npm install -g intelephense"
)

## LSPs installable with go
$GoLsps = @(
    "go install golang.org/x/tools/gopls@latest",
    "go install github.com/go-delve/delve/cmd/dlv@latest",
    "go install golang.org/x/tools/cmd/goimports@latest",
    "go install github.com/nametake/golangci-lint-langserver@latest",
    "go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest",
    "go install github.com/grafana/jsonnet-language-server@latest"
)

## LSPs installable with scoop
$ScoopLsps = @(
    "scoop install marksman",
    "scoop install terraform-ls",
    "scoop install bicep"
)

## LSPs installable with pip
$PipLsps = @(
    "pip install ruff-lsp",
    "pip install ruff"
)

## LSPs installable with pipx
$PipxLsps = @(
    "pipx install jedi-language-server",
    "pipx install python-lsp-server",
    "pipx inject python-lsp-server python-lsp-ruff python-lsp-black"
)

## LSPs installable with rustup
$RustLsps = @(
    "rustup component add rust-analyzer",
    "rustup component add rustfmt"
)

## LSPs installable with cargo
$CargoLsps = @(
    "cargo install taplo-cli --locked --features lsp"
)

## LSPs installable with dotnet
$DotnetLsps = @(
    # OmniSharp requires manual installation from: https://github.com/OmniSharp/omnisharp-roslyn/releases
    # Or install via scoop: scoop install omnisharp
)

## Array of tools to check installation status for
$tools = @("npm", "cargo", "rustup", "dotnet", "pip", "pipx")

## Check if each tool is installed
foreach ($tool in $tools) {
    if (Get-Command $tool -ErrorAction SilentlyContinue) {
        Write-Host "$tool is installed" -ForegroundColor Green
    }
    else {
        Write-Host "$tool is NOT installed" -ForegroundColor Red
    }
}

## Install LSPs with npm
if ( -Not ( Get-Command npm -ErrorAction SilentlyContinue ) ) {
    Write-Warning "npm is not installed, skipping LSP installs that require npm"
}
else {
    Write-Host "Installing LSPs with npm"
    foreach ( $Lsp in $NpmLsps ) {
        try {
            Invoke-Expression $Lsp
        }
        catch {
            Write-Host "Failed to install $Lsp"
        }
    }
}

## Install LSPs with go
if ( -Not ( Get-Command go -ErrorAction SilentlyContinue ) ) {
    Write-Warning "go is not installed, skipping LSP installs that require go"
}
else {
    Write-Host "Installing LSPs with go"
    foreach ( $Lsp in $GoLsps ) {
        try {
            Invoke-Expression $Lsp
        }
        catch {
            Write-Host "Failed to install $Lsp"
        }
    }
}

## Install LSPs with scoop
if ( -Not ( Get-Command scoop -ErrorAction SilentlyContinue ) ) {
    Write-Warning "scoop is not installed, skipping LSP installs that require scoop"
}
else {
    Write-Host "Installing LSPs with scoop"
    foreach ( $Lsp in $ScoopLsps ) {
        try {
            Invoke-Expression $Lsp
        }
        catch {
            Write-Host "Failed to install $Lsp"
        }
    }
}

## Install LSPs with pip
if ( -Not ( Get-Command pip -ErrorAction SilentlyContinue ) ) {
    Write-Warning "pip is not installed, skipping LSP installs that require pip"
}
else {
    Write-Host "Installing LSPs with pip"
    foreach ( $Lsp in $PipLsps ) {
        try {
            Invoke-Expression $Lsp
        }
        catch {
            Write-Host "Failed to install $Lsp"
        }
    }
}

## Install LSPs with pipx
if ( -Not ( Get-Command pipx -ErrorAction SilentlyContinue ) ) {
    Write-Warning "pipx is not installed, skipping LSP installs that require pipx"
}
else {
    foreach ( $Lsp in $PipxLsps ) {
        try {
            Invoke-Expression $Lsp
        }
        catch {
            Write-Host "Failed to install $Lsp"
        }
    }
}

## Install LSPs with rustup
if ( -Not ( Get-Command rustup -ErrorAction SilentlyContinue ) ) {
    Write-Warning "rustup is not installed, skipping LSP installs that require rustup"
}
else {
    foreach ( $Lsp in $RustLsps ) {
        try {
            Invoke-Expression $Lsp
        }
        catch {
            Write-Host "Failed to install $Lsp"
        }
    }
}

## Install LSPs with cargo
if ( -Not ( Get-Command cargo -ErrorAction SilentlyContinue ) ) {
    Write-Warning "cargo is not installed, skipping LSP installs that require cargo"
}
else {
    Write-Host "Installing LSPs with cargo"
    foreach ( $Lsp in $CargoLsps ) {
        try {
            Invoke-Expression $Lsp
        }
        catch {
            Write-Host "Failed to install $Lsp"
        }
    }
}

## Install LSPs with dotnet
if ( -Not ( Get-Command dotnet -ErrorAction SilentlyContinue ) ) {
    Write-Warning "dotnet is not installed, skipping LSP installs that require dotnet"
}
else {
    foreach ( $Lsp in $DotnetLsps ) {
        try {
            Invoke-Expression $Lsp
        }
        catch {
            Write-Host "Failed to install $Lsp"
        }
    }
}
