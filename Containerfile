ARG ALPINE_VERSION=3.23

FROM node:24-alpine${ALPINE_VERSION} AS builder

WORKDIR /build
COPY package*.json ./
RUN npm ci
COPY index.ts ./
RUN npm run build

FROM alpine:${ALPINE_VERSION}

WORKDIR /usr/src/app

RUN \
  # add required binaries
  apk add --no-cache libstdc++ dumb-init \
  # setup user and group
  && addgroup -g 1000 node \
  && adduser -u 1000 -G node -s /bin/sh -D node \
  && chown node:node ./

COPY --from=builder /usr/local/bin/node /usr/local/bin/
COPY --from=builder /usr/local/bin/docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
USER node

COPY --from=builder /build/dist ./

# node not designed to run as PID 1
CMD ["dumb-init", "node", "index.js"]

EXPOSE 80
