FROM nginx:alpine

# Copy the application files to the Nginx image
COPY . /usr/share/nginx/html

# Expose the application port
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]