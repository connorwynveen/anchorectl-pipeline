# Dockerfile for anchorectl demonstration

# Use UBI8 minimal for the base image
FROM registry.access.redhat.com/ubi8-minimal:latest

# Metadata as per OCI image spec annotations
LABEL maintainer="pvn@novarese.net" \
      name="anchorectl-pipeline" \
      org.opencontainers.image.title="anchorectl-pipeline" \
      org.opencontainers.image.description="Simple image to test anchorectl with Anchore Enterprise."

# Set user to root to install packages
USER root

# Install Python and pip
RUN microdnf update -y && \
    microdnf install -y python3 python3-pip && \
    microdnf clean all

# Copy the requirements.txt file to the container
COPY requirements.txt /tmp/requirements.txt

# Install Python packages specified in requirements.txt
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r /tmp/requirements.txt

# Use date to force a unique build every time and other setup commands
RUN set -ex && \
    echo "-----BEGIN OPENSSH PRIVATE KEY-----" > /ssh_key && \
    echo "aws_access_key_id=01234567890123456789" > /aws_access && \
    date > /image_build_timestamp

# Set the entrypoint
ENTRYPOINT ["/bin/false"]
