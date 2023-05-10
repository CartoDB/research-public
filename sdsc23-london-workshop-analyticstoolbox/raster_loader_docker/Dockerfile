FROM ghcr.io/osgeo/gdal:ubuntu-full-latest

# Configure everything to install gum (helper for entrypoint.sh)
RUN mkdir -p /etc/apt/keyrings \   
    && curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list 

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
    gum \
    python3 \
    python3-pip \
    python3-setuptools \
    git

# Install gcloud
## Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

## Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

## Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

## Install from pip
RUN pip3 install raster-loader

WORKDIR /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
