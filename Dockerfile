#Specify base image PHASE 1
FROM node:11.10-alpine as builder

#make or find a folder to copy project
WORKDIR /app

#Copy package.json of your project to container
COPY package.json .
COPY package-lock.json .

#Install some dependencies
RUN npm install

#Copy remaining files(from you project) to container
COPY . .

#Default command
RUN npm run build

#PHASE2
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
#NGINX START IS THE DEFAULT CMD FOR NGINX CONTAINER