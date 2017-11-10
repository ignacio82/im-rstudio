FROM rocker/tidyverse
LABEL maintainer="Ignacio Martinez <ignacio@protonmail.com>"

## install JDK
RUN apt-get -yqq update
RUN apt-get -yqq install openjdk-8-jdk

## add JAVA_HOME
RUN echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /etc/environment
RUN /bin/bash -c 'source /etc/environment'

## configure JAVA and install rJava package
RUN R CMD javareconf
RUN R -e "install.packages('rJava', dependencies = TRUE, repos='https://cran.rstudio.com/')"


# Install Packages
