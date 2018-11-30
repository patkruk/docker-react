# Build Phase
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run Phase
FROM nginx:alpine
# EXPOSE is ignored in your local env, but is used by AWS Beanstalk
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
