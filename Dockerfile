FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run db:generate
RUN npm run build

EXPOSE 5000

# Migrations, example seed row, then API (Railway / Compose)
CMD ["sh", "-c", "npm run db:migrate:deploy && npm run db:seed && node dist/server.js"]