# FROM registry.access.redhat.com/ubi9/nodejs-18
# USER default
# EXPOSE 8080
# ENV NODE_ENV development
# COPY . /opt/app-root/src/
# RUN npm install

USER root

# Build the app using the full Node.js image
FROM registry.access.redhat.com/ubi9/nodejs-18:latest

# Copy package.json and package-lock.json
COPY package*.json ./

# Install all app dependencies
RUN npm install --omit=dev

USER default

# Start with the minimal Node.js image
FROM registry.access.redhat.com/ubi8/nodejs-18-minimal:latest

# Copy all app dependencies
COPY --from=0 /opt/app-root/src/node_modules /opt/app-root/src/node_modules
COPY . /opt/app-root/src

ENV NODE_ENV production
ENV PORT 8080
EXPOSE 8080
CMD ["npm", "start"]
