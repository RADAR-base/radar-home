FROM --platform=$BUILDPLATFORM node:18 as builder

WORKDIR /code
COPY package*.json /code
RUN npm install

COPY src /code/src
RUN npm run build

FROM nginxinc/nginx-unprivileged:1.22-alpine

COPY --from=builder /code/dist /usr/share/nginx/html/
