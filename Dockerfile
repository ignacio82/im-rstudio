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
    libgpgme11-dev libappindicator1 fuse libgconf-2-4 \
    python-pip \
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
        ggjoy optmatch zip\
        blogdown tictoc \
        && R -e "drat::addRepo(account = 'Ignacio', alturl = 'https://drat.ignacio.website/'); \
        install.packages(c('IMSecrets', 'IMWatson', 'themeIM', 'yourls', 'IMPosterior', 'IMBayesian'))"

RUN pip install awscli --upgrade --user

RUN installGithub.r rstudio/rscrypt hrbrmstr/keybase \
   && wget https://prerelease.keybase.io/keybase_amd64.deb \
   && dpkg -i keybase_amd64.deb \
   &&  apt-get install -f \
   &&  rm keybase_amd64.deb \
## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
    
RUN build_deps="curl ca-certificates" && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ${build_deps} && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
    DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove ${build_deps} && \
    rm -r /var/lib/apt/lists/*

        
