FROM rocker/tidyverse
LABEL maintainer="Ignacio Martinez <ignacio@protonmail.com>"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ## for rJava
    default-jdk \
    ## used to build rJava and other packages
    libbz2-dev \
    libicu-dev \
    liblzma-dev \


## configure JAVA and install rJava package
RUN R CMD javareconf
RUN R -e "install.packages('rJava', dependencies = TRUE, repos='https://cran.rstudio.com/')"


