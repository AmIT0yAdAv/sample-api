# Build stage
FROM node:16-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Run linting and tests
RUN npm run lint
RUN npm test

# Build the application (if needed)
RUN npm run build --if-present

# Production stage
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Set node environment to production
ENV NODE_ENV=production

# Copy package files
COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production

# Copy application code
COPY --from=builder /app/src /app/src

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

# Start the application
