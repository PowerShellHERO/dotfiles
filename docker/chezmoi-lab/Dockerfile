
FROM ubuntu:24.04

RUN apt update && apt install -y sudo git curl zsh

RUN useradd -m -s /bin/zsh yourname \
    && echo "yourname:do" | chpasswd \
    && usermod -aG sudo yourname

USER yourname
WORKDIR /home/yourname

