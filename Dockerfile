FROM nginxinc/nginx-unprivileged:1.18.0-alpine

COPY dist /usr/share/nginx/html/

CMD ["nginx", "-g", "daemon off;"]
