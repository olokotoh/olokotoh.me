# FROM nginx:alpine

# # Copy the application files to the Nginx image
# COPY . /usr/share/nginx/html

# # Expose the application port
# EXPOSE 80

# # Start the Nginx server
# CMD ["nginx", "-g", "daemon off;"]
FROM nginx:alpine

# Install curl (needed for loki-entry)
RUN apk add --no-cache curl

# Download and install loki-entry
RUN curl -o /usr/local/bin/loki-entry -L https://github.com/grafana/loki/releases/download/v2.7.1/loki-linux-amd64 && \
    chmod +x /usr/local/bin/loki-entry

# Copy the application files to the Nginx image
COPY . /usr/share/nginx/html

# Loki logging driver configuration
ENV LOKI_URL="http://loki:3100/loki/api/v1/push"
ENV LOKI_LABELS="app=my-nginx,env=production"
ENV LOKI_BATCHWAIT="5s"

# Start the Nginx server using loki-entry
CMD ["sh", "-c", "nginx -g 'daemon off;' 2>&1 | loki-entry"]
