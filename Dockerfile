FROM nginx:stable-alpine3.17

COPY build/web /usr/share/nginx/html/web
COPY nginx.conf /etc/nginx/conf.d/default.conf