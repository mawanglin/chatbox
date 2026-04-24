# ---- Base ----
#FROM node:22-alpine AS base
FROM node:22-trixie AS base
RUN npm install -g pnpm@10
WORKDIR /app
COPY package.json pnpm-lock.yaml .npmrc ./
COPY patches ./patches/
COPY .erb/scripts ./.erb/scripts/

# ---- Dependencies ----
FROM base AS dependencies
# 本地构建时可取消注释以使用国内镜像加速
# RUN pnpm config set registry https://registry.npmmirror.com/
RUN pnpm install --frozen-lockfile

# ---- Build ----
FROM dependencies AS build
COPY . .
RUN pnpm run build:web

# ---- Production ----
FROM nginx:alpine AS production
COPY --from=build /app/release/app/dist/renderer /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]