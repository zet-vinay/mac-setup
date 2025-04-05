#!/bin/bash

core_setup() {
  ######################
  ## 1. Homebrew
  ######################
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Homebrew already installed."
  fi

  ######################
  ## 2. Install Base Tools
  ######################
  echo "Installing CLI tools via Brew..."
  brew install warp
  brew install tmux bat exa fd ripgrep htop tldr lazygit zoxide fzf direnv

  ######################
  ## 3. Zsh & Oh My Zsh
  ######################
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes CHSH=no sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "Oh My Zsh already installed."
  fi

  ######################
  ## 4. Powerlevel10k + Nerd Fonts
  ######################
  echo "Installing Powerlevel10k and Meslo Nerd Font..."
  brew tap homebrew/cask-fonts
  brew install --cask font-meslo-lg-nerd-font

  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
      "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  fi

  ######################
  ## 5. Zsh Plugins
  ######################
  echo "Installing Zsh plugins..."
  ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  git clone https://github.com/zsh-users/zsh-autosuggestions \
    $ZSH_CUSTOM/plugins/zsh-autosuggestions

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

  git clone https://github.com/agkozak/zsh-z \
    $ZSH_CUSTOM/plugins/zsh-z

  ######################
  ## 6. Configure .zshrc
  ######################
  echo "Configuring .zshrc..."
  sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
  sed -i '' 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-z)/' ~/.zshrc

  if ! grep -q "source ~/.p10k.zsh" ~/.zshrc; then
    echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc
  fi
}
