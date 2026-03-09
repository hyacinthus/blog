FROM hugomods/hugo:go AS builder
COPY . /src
ARG HUGO_ENV=zh
WORKDIR /src
RUN hugo --minify -e ${HUGO_ENV}

FROM caddy:2-alpine
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=builder /src/public /srv
EXPOSE 80 443
