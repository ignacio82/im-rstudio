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
    htop \
    libgpgme11-dev \
## V8
    libv8-3.14-dev \
## ssh
    openssh-client \
# Install Packages
   && install2.r --error \
        googleComputeEngineR googleCloudStorageR \
        secret \
        drat \
        V8 \
        Julia future future.apply\
        StanHeaders rstan rstanarm KernSmooth \
        ggjoy optmatch ghit zip\
        blogdown tictoc \
        && R -e "drat::addRepo(account = 'Ignacio', alturl = 'https://drat.ignacio.website/'); \
        install.packages(c('IMSecrets', 'IMWatson', 'themeIM', 'yourls', 'IMPosterior', 'IMBayesian'))" \
   && RUN installGithub.r hrbrmstr/keybase \
## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
        
