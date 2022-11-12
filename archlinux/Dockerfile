FROM archlinux:base

ARG USER_ID
ARG GROUP_ID
ARG USERNAME

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    groupadd -g ${GROUP_ID} ${USERNAME} && \
    useradd -l -u ${USER_ID} -g ${USERNAME} ${USERNAME} && \
    mkdir -p /home/${USERNAME} && \
    install -d -m 0755 -o ${USERNAME} -g ${USERNAME} /home/${USERNAME} && \
    chown -R ${USER_ID}:${GROUP_ID} /home/${USERNAME} \
;fi

ENV TZ="Asia/Singapore"
ENV HOME="/home/${USERNAME}"

RUN pacman --noconfirm -Syu nodejs npm rust wget git make neovim \
        fish git-delta rsync exa fd bat ripgrep fortune-mod fzf unzip zoxide && \
    pacman --noconfirm -Scc

USER ${USERNAME}

RUN mkdir -p $HOME/installation

WORKDIR $HOME/installation

RUN wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh && \
    chmod +x install.sh && \
    npm config set force=true && \
    LV_BRANCH='master' ./install.sh -y --install-dependencies && \
    export PATH=$HOME/.local/bin:$PATH && \
    git clone https://github.com/dann20/dotfiles-minimal.git && \
    rsync -ra --delete dotfiles-minimal/.config/lvim $HOME/.config/ && \
    rsync -ra --delete dotfiles-minimal/.config/fish $HOME/.config/ && \
    rsync -ra --delete dotfiles-minimal/.config/bat $HOME/.config/ && \
    rsync -ra --delete dotfiles-minimal/.config/fd $HOME/.config/ && \
    rsync -ra --delete dotfiles-minimal/.config/ripgrep $HOME/.config/ && \
    rsync -ra --delete dotfiles-minimal/.config/git $HOME/.config/ && \
    rsync -ra --delete dotfiles-minimal/.config/lazygit $HOME/.config/ && \
    exit 0

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p $HOME/miniconda

WORKDIR $HOME

RUN rm -rd $HOME/installation

ENTRYPOINT [ "fish" ]
