FROM nginx:alpine

# Install curl (needed for loki-entry)
RUN apk add --no-cache curl

# Download and install loki-entry
RUN curl -o /usr/local/bin/loki-entry -L https://github.com/grafana/loki/releases/download/v2.7.1/loki-linux-amd64 && \
    chmod +x /usr/local/bin/loki-entry

# Copy the application files to the Nginx image
COPY . /usr/share/nginx/html

# Expose the port for Nginx
EXPOSE 80

# Start the Nginx server using loki-entry
CMD ["sh", "-c", "nginx -g 'daemon off;' 2>&1 | loki-entry"]
