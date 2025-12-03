# -------- Node Build Container --------
FROM node:20-alpine

WORKDIR /app

# Copy package.json & package-lock.json
COPY package*.json ./

# Install dependencies including devDependencies
RUN npm ci

# Copy rest of the project
COPY . .

# Fix Webpack 4 + Node 20 OpenSSL error
ENV NODE_OPTIONS="--openssl-legacy-provider"

# Build frontend assets
RUN npm run production

# Optionally: keep container lightweight by removing node_modules devDependencies if not needed after build
RUN npm prune --production
