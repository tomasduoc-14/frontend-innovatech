# ===== STAGE 1: Build =====
FROM node:18-alpine AS builder

WORKDIR /app
COPY src/ ./src/

# ===== STAGE 2: Production con Nginx =====
FROM nginx:alpine AS production

RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

COPY --from=builder /app/src /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]