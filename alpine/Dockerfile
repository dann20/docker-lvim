FROM alpine:edge

ARG USER_ID
ARG GROUP_ID
ARG USERNAME

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    addgroup -S -g ${GROUP_ID} ${USERNAME} && \
    adduser -S -u ${USER_ID} -G ${USERNAME} -h /home/${USERNAME} -H ${USERNAME} && \
    install -d -m 0755 -o ${USERNAME} -g ${USERNAME} /home/${USERNAME} && \
    chown -R ${USER_ID}:${GROUP_ID} /home/${USERNAME} \
;fi

ENV TZ="Asia/Singapore"
ENV HOME="/home/${USERNAME}"

RUN apk update && \
    apk add --no-cache nodejs npm rust wget git make neovim bash python3 g++ \
        fish delta rsync exa fd bat ripgrep fortune fzf unzip zoxide curl

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk && \
    apk add --force-overwrite glibc-2.35-r0.apk

USER ${USERNAME}

RUN mkdir $HOME/.npm-global && \
    npm config set prefix '~/.npm-global' && \
    export PATH=$HOME/.npm-global/bin:$PATH

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

WORKDIR $HOME

RUN rm -rf $HOME/installation

ENTRYPOINT [ "fish" ]
