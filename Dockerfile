FROM node:10-slim
RUN apt-get update  && apt-get install -y nginx

RUN mkdir -p /app/
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install
COPY . .
RUN npm run build
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
RUN cp -r dist/* /app/ \
    && rm -rf /user/src/app
COPY ./nginx.conf /etc/nginx/nginx.conf
ENV PORT 80
EXPOSE 80
CMD sh -c "exec nginx -c /etc/nginx/nginx.conf -g 'daemon off;'"

