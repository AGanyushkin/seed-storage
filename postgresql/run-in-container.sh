#!/usr/bin/env zsh

# Build image
# docker build -t test-pg:v1 -f Dockerfile .

# Run for tests
docker run --rm -p 25432:5432 -e POSTGRES_PASSWORD=123 test-pg:v1
