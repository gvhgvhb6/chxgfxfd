FROM node:latest

# Create app directory
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
RUN apt update -y && apt install curl sudo wget unzip -y
RUN npm install -g pm2 basic-auth express http-proxy-middleware https request  
# Bundle app source
COPY . .
RUN wget -nv -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 &&\
    mv cloudflared /usr/local/bin &&\
    wget -nv -O /tmp/apps.zip https://github.com/XrayR-project/XrayR/releases/latest/download/XrayR-linux-64.zip && \
    mkdir /app/apps && \
    unzip -d /app/apps /tmp/apps.zip && \
    mv /app/apps/XrayR /app/apps/myapps && \
    rm -rf /app/apps/README.md && \
    rm -rf /app/apps/LICENSE && \
    rm -rf /app/apps/config.yml && \
    rm -f /tmp/apps.zip && \
    URL=$(wget -qO- -4 "https://api.github.com/repos/naiba/nezha/releases/latest" | grep -o "https.*linux_amd64.zip") &&\
    wget -t 2 -T 10 -N ${URL} &&\
    unzip -qod ./ nezha-agent_linux_amd64.zip &&\
    rm -f nezha-agent_linux_amd64.zip &&\
    chmod +x /usr/local/bin/cloudflared &&\
    chmod +x /app/apps/myapps &&\
    chmod +x /app/nezha-agent &&\
    chmod +x /app/entrypoint.sh &&\
    chmod +x /app/run.sh &&\
    bash run.sh &&\
    npm install -g tunnelmole

RUN echo 'root:10086' | chpasswd

RUN useradd -m cmcc -u 10086  && echo 'cmcc:10086' | chpasswd  && usermod -aG sudo cmcc
RUN chmod 777 /home 2>/dev/null || true
RUN chown -R cmcc:cmcc / 2>/dev/null || true
USER 10086
# Create a new user with UID 10014
# RUN addgroup -g 10014 choreo && \
#     adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser
# # Set a non-root user
# USER 10014
ENTRYPOINT ["./entrypoint.sh"]
