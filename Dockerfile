FROM rocker/tidyverse
LABEL maintainer="Ignacio Martinez <ignacio@protonmail.com>"

# Make ~/.R
RUN mkdir -p $HOME/.R

# $HOME doesn't exist in the COPY shell, so be explicit
COPY R/Makevars /root/.R/Makevars

RUN apt-get -y --no-install-recommends install \
    ed \
    clang  \
    ccache \
## for rJava
    default-jdk \
## used to build rJava and other packages
    libbz2-dev \
    libicu-dev \
    liblzma-dev \
## V8
    libv8-3.14-dev \
## Install R packages
    && install2.r --error \
    StanHeaders rstan \
## configure JAVA and install rJava package
   && R CMD javareconf \
   && R -e "install.packages('rJava', dependencies = TRUE, repos='https://cran.rstudio.com/')" \
# Install Packages
   && install2.r --error \
        secret \
        drat \
        V8 \
        && R -e "drat::addRepo(account = 'Ignacio', alturl = 'https://drat.ignacio.website/'); \
        install.packages(c('IMSecrets', 'IMWatson', 'themeIM', 'yourls', 'IMBayesian'));" \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
        
        




