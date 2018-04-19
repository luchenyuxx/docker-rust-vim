FROM rust:latest

ENV USER chenyu

RUN apt update
RUN apt -y upgrade
RUN apt -y install tmux zsh curl vim git
RUN apt -y install python python3
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -O - | zsh || true

COPY . /root

RUN rustup component add rustfmt-preview


RUN cargo install racer

RUN rustup component add rust-src

RUN rustup update

RUN echo "export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src" >> ~/.zshrc

RUN vim -u NONE -S ~/.vim/vimrcs/plugins.vim +PlugInstall +qall > /dev/null

ENV SHELL /usr/bin/zsh

ENTRYPOINT zsh
