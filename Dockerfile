# Docker file to build Klab's toolbox

# Base image
FROM ubuntu:focal

# LABEL about the docker image
LABEL description="Klab's collection of Linux applications"

# Disable prompt during packages installation
ARG DEBIAN_FRONTEND=noninteractive

# Install dependecies
RUN apt-get update && apt-get upgrade -y --no-install-recommends
RUN apt-get install -y --no-install-recommends \
            cscope curl dbus-x11 file git glances global sqlite3 sudo tig tree sqlite3 universal-ctags vim wget \
            eog evince file-roller firefox gedit giggle gitg gitk gnome-system-monitor gnome-terminal gthumb \
            meld nautilus nemo synapse terminator tilda tilix xdiskusage xfe xterm
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy startup scripts
COPY scripts/menu.sh /usr/local/bin/menu
COPY scripts/entrypoint.sh /entrypoint.sh

# Update file permissions
RUN chmod +x /entrypoint.sh
RUN chmod +x /usr/local/bin/menu

# Create local user
ARG USER=klab
RUN useradd -m ${USER} -s /bin/bash
RUN usermod -aG sudo ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER}

USER ${USER}
WORKDIR /home/${USER}

# Run entrypoint
ENTRYPOINT ["/entrypoint.sh"]
