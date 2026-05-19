# Use the official Bun image
FROM oven/bun:1.1-slim AS base
WORKDIR /app

# Install dependencies
FROM base AS install
RUN mkdir -p /temp/dev
COPY package.json bun.lock /temp/dev/
RUN cd /temp/dev && bun install --frozen-lockfile

# Copy dependencies and source code
FROM base AS release
COPY --from=install /temp/dev/node_modules node_modules
COPY . .

# Expose the port Astro runs on
EXPOSE 4321

# Start the dev server by default
# Binding to 0.0.0.0 is handled via astro.config.mjs
CMD ["bun", "run", "dev"]
