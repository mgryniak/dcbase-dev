FROM debian:12-slim
LABEL maintainer "Michał Gryniak <mgryniak@gmail.com>"
ENV TZ UTC
ARG DEBIAN_FRONTEND=noninteractive
#-------------------------------------------------
# Clean packages
RUN apt-get clean autoclean && apt-get purge -y --auto-remove && rm -rf /var/lib/{apt,dpkg,cache,log}/
#-------------------------------------------------
# Base packages
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        apt-utils apt-transport-https ca-certificates lsb-release locales curl software-properties-common zip unzip gnupg2 wget sudo mc htop jq
#-------------------------------------------------
# Set locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
#-------------------------------------------------
# Configure users
RUN useradd -m -d /home/dev -s /bin/bash dev
RUN echo "dev:dev" | chpasswd
RUN usermod -aG sudo dev  
#-------------------------------------------------

#-------------------------------------------------
# Clean image
RUN apt-get clean autoclean && apt-get purge -y --auto-remove && rm -rf /var/lib/{apt,dpkg,cache,log}/
CMD ["/bin/bash"]
