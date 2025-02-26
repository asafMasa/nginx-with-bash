# Stage 1: Builder
FROM alpine:latest AS builder

# Install Bash (not strictly needed in the final image)
RUN apk add --no-cache bash --no-check-certificate

# Create script directory
WORKDIR /scripts

# Add a sample shell script
COPY start.sh .

# Ensure it's executable
RUN chmod +x start.sh


# Stage 2: Final Nginx Image
FROM nginx:alpine

# Copy the script from the builder
COPY --from=builder /scripts/start.sh /usr/local/bin/start.sh

# Ensure correct permissions
RUN chmod +x /usr/local/bin/start.sh

# Use /bin/sh instead of Bash
CMD ["/bin/sh", "-c", "/usr/local/bin/start.sh"]
