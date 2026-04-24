# ---- Base ----
FROM node:22-alpine AS base
RUN corepack enable
WORKDIR /app
COPY package.json pnpm-lock.yaml ./

# ---- Dependencies ----
FROM base AS dependencies
RUN pnpm config set registry https://registry.npmmirror.com/ && \
    pnpm install --frozen-lockfile --ignore-scripts

# ---- Build ----
FROM dependencies AS build
COPY . .
RUN pnpm run build:web

# ---- Production ----
FROM nginx:alpine AS production
COPY --from=build /app/release/app/dist/renderer /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]