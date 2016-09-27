FROM debian:jessie

# The following commands enclosed in dashes are copied from the google/cloud-sdk
# container Dockerfile https://hub.docker.com/r/google/cloud-sdk/~/dockerfile/
# If there are upstream changes in the container copy those into the Dockerfile here

#----------
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y wget unzip python php5-mysql php5-cli php5-cgi openjdk-7-jre-headless openssh-client python-openssl curl && apt-get clean

RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --disable-installation-options
RUN yes | google-cloud-sdk/bin/gcloud components update
RUN google-cloud-sdk/bin/gcloud --quiet config set component_manager/disable_update_check true

RUN mkdir /.ssh
ENV PATH /google-cloud-sdk/bin:$PATH
ENV HOME /

RUN curl -sSL https://get.docker.com/ | sh

COPY scripts/ /usr/bin/
