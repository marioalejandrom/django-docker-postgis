# Base Image
ARG PYTHON_VERSION=3.12
FROM python:${PYTHON_VERSION}-slim-bullseye AS python-base

LABEL maintainer="mario@mmorales.dev"
LABEL last_updated="2025-01-23"

# Environment Configuration
ENV PYTHONUNBUFFERED=1
ENV PATH="/py/bin:$PATH"

# Set Working Directory
WORKDIR /app

# Copy Application Files and Requirements
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

# Expose Port
EXPOSE 8000

# Development Mode Argument
ARG DEV=false

# Install Build Dependencies, GDAL, and Python Packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        build-essential \
        python3-dev \
        libffi-dev \
        libpq-dev \
        libpq5 \
        gdal-bin \
        libgdal-dev \
        libgeos-dev && \
    apt-mark manual \
        gcc \
        libpq-dev \
        build-essential \
        python3-dev \
        libffi-dev \
        gdal-bin \
        libgdal-dev \
        libgeos-dev && \
    python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install --no-cache-dir -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then \
        /py/bin/pip install --no-cache-dir -r /tmp/requirements.dev.txt; \
    fi && \
    apt-get purge -y --auto-remove \
        gcc \
        build-essential \
        python3-dev \
        libffi-dev \
        libpq-dev && \
    rm -rf /tmp /var/lib/apt/lists/*

# Add a Non-Root User for Security
RUN adduser --disabled-password --no-create-home django-user

# Switch to Non-Root User
USER django-user