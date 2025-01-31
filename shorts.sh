#lets brew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

After Installation, Add Homebrew to Your Path

If the installation completes but brew is still not found, you need to add it to your shell configuration file:

For Apple Silicon (M1, M2, M3 Macs)

echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/usr/local/bin/brew shellenv)"
