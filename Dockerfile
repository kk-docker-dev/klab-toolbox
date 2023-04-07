# Docker file to build Linux toolbox

# Base image
FROM klab/ubuntu:latest

# About this docker image
LABEL MAINTAINER="Kirubakaran Shanmugam <kribakarans@gmail.com>"
LABEL DESCRIPTION="Linux application toolbox"

# Install required packages
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends \
            adwaita-icon-theme-full yaru-theme-gtk \
            cscope curl dbus-x11 file git glances global sqlite3 sudo tig tree sqlite3 universal-ctags vim wget \
            eog evince file-roller firefox gedit giggle gitg gitk gnome-system-monitor gnome-terminal gthumb \
            meld nautilus nemo shotwell synapse terminator tilda tilix xdiskusage xfe xterm

# Clean repositories
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy source
COPY src /klab
RUN install -D /klab/menu.sh /usr/local/bin/menu

# Create local user
ARG USER=klab
RUN useradd -m ${USER} -s /bin/bash && \
    usermod -aG sudo ${USER} && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER}

USER ${USER}
WORKDIR /home/${USER}

# Run entrypoint
ENTRYPOINT [ "/klab/init.sh" ]
