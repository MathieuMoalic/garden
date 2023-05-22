FROM node:20-alpine3.17
WORKDIR /app
ENV HOST=0.0.0.0
ENV PORT=15000
EXPOSE 15000
CMD [ "npm", "run", "dev"]
