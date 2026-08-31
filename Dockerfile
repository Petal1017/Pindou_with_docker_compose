FROM node:22-alpine AS build

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM nginx:1.27-alpine AS runtime

RUN apk add --no-cache jq

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY docker/entrypoint.sh /usr/local/bin/pindou-entrypoint
COPY --from=build /app/dist /usr/share/nginx/html

RUN chmod +x /usr/local/bin/pindou-entrypoint

EXPOSE 80

HEALTHCHECK --interval=10s --timeout=3s --retries=5 \
  CMD wget -q --spider http://127.0.0.1/healthz || exit 1

ENTRYPOINT ["/usr/local/bin/pindou-entrypoint"]
