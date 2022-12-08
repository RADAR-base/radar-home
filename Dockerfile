FROM --platform=$BUILDPLATFORM node:18 as builder

WORKDIR /code
COPY package*.json /code/
RUN npm install

COPY src /code/src
COPY tailwind.config.js /code/
RUN npm run build

FROM nginxinc/nginx-unprivileged:1.22-alpine

COPY docker/30-env-subst.sh /docker-entrypoint.d/
COPY --from=builder /code/dist /usr/share/nginx/html/
COPY --from=builder --chown=101 /code/dist/index.html /usr/share/nginx/html/

ENV S3_ENABLE="" S3_URL="" \
  DASHBOARD_ENABLE="" DASHBOARD_URL="" \
  UPLOAD_PORTAL_ENABLE="" \
  REST_AUTHORIZER_ENABLE=""
