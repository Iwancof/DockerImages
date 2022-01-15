FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update --fix-missing

RUN apt-get -y install libc6 libc6-dbg
RUN apt-get -y install curl wget
RUN apt-get -y install binutils tar git neovim zsh
RUN apt-get -y install make gcc g++ cargo
# RUN apt-get -y install nodejs npm
RUN apt-get -y install tmux sudo
RUN apt-get -y install gdbserver gdb ssh rr
RUN apt-get -y install python3 python3-distutils


# Add files and key
RUN mkdir -p /root/.ssh
RUN mkdir -p /run/sshd

RUN wget https://bootstrap.pypa.io/get-pip.py -O /root/get-pip.py
RUN python3 /root/get-pip.py
RUN pip install --upgrade pip

RUN mkdir -p /root/pwndbg
RUN git clone --depth 1 https://github.com/pwndbg/pwndbg.git /root/pwndbg
RUN mkdir -p /root/ret-sync
RUN git clone --depth 1 https://github.com/bootleg/ret-sync.git /root/ret-sync
RUN mkdir -p /root/gdb_note_addr/
RUN git clone --depth 1 https://github.com/Iwancof/gdb_mynote.git /root/gdb_note_addr
RUN mkdir -p /root/splitmind
RUN git clone --depth 1 https://github.com/jerdna-regeiz/splitmind.git /root/splitmind
RUN pip install -r /root/pwndbg/requirements.txt

RUN apt-get -y install golang
RUN go get -u github.com/relastle/pmy
RUN cargo install exa

RUN curl -fsSL https://starship.rs/install.sh -o install.sh
RUN bash ./install.sh -y

RUN apt-get -y install jq fzf

COPY ./id_ed25519.pub /root/.ssh/authorized_keys
COPY ./sshd_config /etc/ssh/sshd_config
COPY ./nvim /root/.config/nvim
COPY ./zsh /root/.config/zsh
COPY ./gdbinit /root/.gdbinit
RUN ln -s /root/.config/zsh/main.zcfg /root/.zshrc

RUN chsh -s /bin/zsh root

RUN ls /root -lh

EXPOSE 22
WORKDIR /root
USER root
ENTRYPOINT /usr/sbin/sshd -D
