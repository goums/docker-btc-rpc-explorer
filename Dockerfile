ARG VERSION=v2.0.2

FROM node:12-buster-slim AS builder

ARG VERSION

WORKDIR /build

RUN apt-get update

RUN apt-get install -y git

RUN git clone --branch $VERSION https://github.com/janoside/btc-rpc-explorer .

RUN npm ci --production

USER 1000

WORKDIR /data

COPY --from=builder /build .

EXPOSE 3002

CMD [ "npm", "start" ]
