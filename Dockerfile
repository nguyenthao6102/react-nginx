# Multi-stage
# 1) Node image for building frontend assets
# 2) nginx stage to serve frontend assets

FROM node:14-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.19-alpine AS server

COPY --from=builder ./app/build /usr/share/nginx/html