FROM node:16-alpine as builder
WORKDIR "/app"

COPY package.json .
COPY package-lock.json .
RUN npm ci
COPY . .
RUN npm run build

# /app/build will have all assets

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html