FROM alpine AS builder
RUN apk add --no-cache nodejs npm git

RUN npm install npm -g

RUN adduser -D app
USER app
WORKDIR /home/app

RUN git clone https://github.com/louislam/uptime-kuma.git
WORKDIR /home/app/uptime-kuma

RUN echo "================================================================="
RUN ls -al
RUN echo "================================================================="
RUN pwd
RUN echo "================================================================="

# 创建data文件夹并移动kuma.db
RUN mkdir -p /home/app/uptime-kuma/data
RUN mv /home/app/uptime-kuma/db/kuma.db /home/app/uptime-kuma/data/

RUN npm run setup

EXPOSE 3001
CMD ["node", "server/server.js"]
