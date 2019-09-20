FROM nginx:alpine

ENV PORT 80
EXPOSE 80
RUN mkdir -p /app/
COPY ./dist /app/
COPY ./nginx.conf /etc/nginx/nginx.conf
WORKDIR /app

CMD sh -c "exec nginx -g 'daemon off;'"
