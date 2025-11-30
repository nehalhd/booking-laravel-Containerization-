
FROM node:20-alpine AS node_builder

WORKDIR /app

COPY package*.json ./

RUN npm install --production=false

COPY . .


# Fix Webpack 4 + Node 20 OpenSSL error
ENV NODE_OPTIONS="--openssl-legacy-provider"

RUN npm run production
