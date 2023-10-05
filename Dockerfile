FROM registry.access.redhat.com/ubi9/nodejs-18
USER default
EXPOSE 8080
ENV NODE_ENV development
COPY . /opt/app-root/src/
RUN npm install
