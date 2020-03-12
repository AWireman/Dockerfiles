FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
#GENERAL UPDATES
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get update -y && apt-get upgrade -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository universe
RUN apt-get install -y cups curl sudo libgconf2-4 iputils-ping wget xdg-utils libpango1.0-0 fonts-liberation
RUN apt-get update -y && apt-get install -y software-properties-common && apt-get install -y locales
#ADD USER, FISH CONFIG, MOUNTED DRIVES
ENV USER='dev'
ENV PASSWORD='dev'
RUN groupadd -r $USER -g 433 \ 
    && useradd -u 431 -r -g $USER -d /home/$USER -s /usr/bin/fish -c "$USER" $USER \
    && adduser $USER sudo \
    && mkdir /home/$USER \
    && mkdir -p /home/$USER/.config/fish \
    && mkdir -p /home/$USER/pool \
    && chown -R $USER:$USER /home/$USER \
    && chown -R $USER:$USER /home/$USER/.config/fish \
    && chown -R $USER:$USER /home/$USER/pool \
    && touch /home/$USER/.config/fish/fish.config \
    && echo $USER':'$PASSWORD | chpasswd \
#CONFIGURE TIMEZONE AND LOCALE
ENV LANG="en_US.UTF_8"
ENV LANGUAGE=en_US
RUN locale-gen en_US.UTF-8
RUN locale-gen en_US
RUN echo "Europe/Copenhaven" > /etc/timezone \
    && apt-get install -y locales \
    && sed -i -e "s/# $LANG.*/$LANG.UTF-8 UTF8/" /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=$LANG
#INSTALL STUFF
RUN apt-get install -y nano \
    vim net-tools tmux fish default-jdk \
    curl apache2 autoconf automake unzip \
    cmake clang clang-format clang-tidy default-jre \
    dnsutils g++ gcc gcc-8 gdb git htop golang golang-golang-x-tools \
    make mysql-client mysql-server mysql-utilities \
    openssh-client openssh-server mongodb nodejs perl php zip
#CONDA
RUN bash 
#ALIAS
RUN echo 'tmux' >> /home/dev/.bashrc
RUN echo 'alias c="clear"' >> /home/dev/.bash_profile
RUN echo 'alias ls="ls -ltr"' >> /home/dev/.bash_profile
RUN echo 'alias django="conda activate /home/dev/pool/3_DEV/conda/.conda/djangoWebsite/; cd /home/dev/pool/3_DEV/git/djangoWebsite/djangoWebsite; source /home/dev/pool/3_DEV/git/djangoWebsite/djangoWebsite/.alias"' >> /home/dev/.bash_profile
RUN cp /home/dev/.bash_profile /home/dev/.config/fish/fish.config
RUN echo 'source /home/dev/.bash_profile' >> /home/dev/.config/fish/config.fish
#TMUX CONFIG

