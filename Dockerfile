FROM alpine AS builder

RUN apk add --no-cache nodejs npm git
RUN npm install npm -g

RUN adduser -D app
USER app

WORKDIR /home/app/data
RUN git clone https://github.com/ling290/uptime-kuma.git
WORKDIR /home/app

RUN git clone https://github.com/louislam/uptime-kuma.git
WORKDIR /home/app/uptime-kuma

RUN echo "=============== 列出当前工作所在的路径 ==============="
RUN pwd
RUN echo "=============== 遍历当前工作所在的路径下的内容 ==============="
RUN ls -al

# 创建data文件夹并移动kuma.db
RUN mkdir -p /home/app/uptime-kuma/data
RUN mv /home/app/data/uptime-kuma/db/kuma.db /home/app/uptime-kuma/data/
RUN echo "=============== 遍历 /home/app/uptime-kuma/data/ 路径下的内容 ==============="
RUN ls -al /home/app/uptime-kuma/data/

RUN npm run setup

EXPOSE 3001
CMD ["node", "server/server.js"]
