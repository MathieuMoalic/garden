FROM node:20-alpine3.17
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
RUN npm prune --production
ENV HOST=0.0.0.0
ENV PORT=15010
EXPOSE 15010
CMD [ "npm", "start"]