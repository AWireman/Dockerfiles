FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
#GENERAL UPDATES
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get update -y && apt-get upgrade -y && apt-get install -y curl
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN mkdir -p ~/.config/code-server && touch ~/.config/code-server/config.yaml
COPY /config.yaml /root/.config/code-server/config.yaml
CMD ["code-server"]
