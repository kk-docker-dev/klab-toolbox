# Docker file to build Linux toolbox

# Ubuntu base image
FROM ubuntu:focal

# LABEL about the docker image
LABEL description="Klab's collection of Linux applications"

# Disable user prompt
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade the system
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends

# Install base packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends locales tzdata

# Setting timezone
RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Setting locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 && \
    locale-gen en_US.UTF-8

# Setting language
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install linux packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            adwaita-icon-theme-full yaru-theme-gtk \
            cscope curl dbus-x11 file git glances global sqlite3 sudo tig tree sqlite3 universal-ctags vim wget \
            eog evince file-roller firefox gedit giggle gitg gitk gnome-system-monitor gnome-terminal gthumb \
            meld nautilus nemo shotwell synapse terminator tilda tilix xdiskusage xfe xterm
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
