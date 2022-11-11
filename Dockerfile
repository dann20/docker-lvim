FROM archlinux:base

RUN pacman --noconfirm -Syu nodejs npm rust wget git make neovim \
    fish git-delta rsync exa fortune-mod fzf

WORKDIR /root/installation

RUN wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh \
    && chmod +x install.sh \
    && npm config set force=true \
    && LV_BRANCH='master' ./install.sh -y --install-dependencies \
    && export PATH=/root/.local/bin:$PATH \
    && git clone https://github.com/dann20/dotfiles-minimal.git \
    && rsync -ra --delete dotfiles-minimal/.config/lvim /root/.config/ \
    && rsync -ra --delete dotfiles-minimal/.config/fish /root/.config/ \
    && rsync -ra --delete dotfiles-minimal/.config/bat /root/.config/ \
    && rsync -ra --delete dotfiles-minimal/.config/fd /root/.config/ \
    && rsync -ra --delete dotfiles-minimal/.config/ripgrep /root/.config/ \
    && rsync -ra --delete dotfiles-minimal/.config/git /root/.config/ \
    && rsync -ra --delete dotfiles-minimal/.config/lazygit /root/.config/ \
    && exit 0

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh -O miniconda.sh \
    bash miniconda.sh -b -p $HOME/miniconda

WORKDIR /root
