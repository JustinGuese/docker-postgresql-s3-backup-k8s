#!/bin/bash
docker buildx build --platform linux/amd64 -t guestros/postgres-s3-backup:latest --push . --no-cache
# ,linux/arm64