FROM alpine AS builder
RUN apk add --no-cache nodejs npm git

RUN npm install npm -g

RUN mkdir -p /app
WORKDIR /app

RUN git clone https://github.com/ling290/uptime-kuma.git .
RUN echo '遍历克隆下的仓库目录：@@@@@@@@@@@@@@@@@@@@@@@@@@'
RUN ls -al /app/
RUN cp -r /app/db/* /app/data/
RUN echo '查看是否复制数据库成功：@@@@@@@@@@@@@@@@@@@@@@@@'
RUN ls -al /app/data/
WORKDIR /app/
RUN cp -r /app/db/* /app/data/
RUN npm run setup

EXPOSE 3001
CMD ["node", "server/server.js"]
