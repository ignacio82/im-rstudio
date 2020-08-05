FROM rocker/verse:latest
LABEL maintainer="Ignacio Martinez <ignacio@protonmail.com>"

# Make ~/.R
RUN mkdir -p $HOME/.R 

# $HOME doesn't exist in the COPY shell, so be explicit
COPY R/Makevars root/.R/Makevars 

RUN echo "rstan::rstan_options(auto_write = TRUE)\n" >> /home/rstudio/.Rprofile \
    && echo "options(mc.cores = parallel::detectCores())\n" >> /home/rstudio/.Rprofile

RUN apt-get update \
   && apt-get -y --no-install-recommends install \
      apt-utils \
      ed \
      libnlopt-dev \
## V8
    libv8-dev \
## sodium
    libsodium-dev \
# Update Pandoc
   && wget https://github.com/jgm/pandoc/releases/download/2.7.1/pandoc-2.7.1-1-amd64.deb \
   && dpkg -i pandoc-2.7.1-1-amd64.deb \
   && rm pandoc-2.7.1-1-amd64.deb \
   && rm  /usr/lib/rstudio-server/bin/pandoc/pandoc \
   && rm /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc \
   && ln -s /usr/local/bin/pandoc /usr/lib/rstudio-server/bin/pandoc/ \
   && ln -s /usr/local/bin/pandoc-citeproc /usr/lib/rstudio-server/bin/pandoc/ \
# Install Packages
   && install2.r --error \
        googleComputeEngineR \
        googleCloudStorageR \
        secret \
        drat \
        V8 \
        Julia \
        future \
        future.apply\
        StanHeaders \
        rstan \
        rstantools \
        KernSmooth \
        ggjoy \
        optmatch \
        zip \
        blogdown \
        tictoc \
        remotes \
        remoter \
        sodium  \
        bayesplot \
        vizdraws \
        && R -e "drat::addRepo(account = 'Ignacio', alturl = 'https://drat.ignacio.website/'); \
        install.packages(c('IMSecrets', 'themeIM'))" \
  && R -e "remotes::install_github('rstudio/pagedown')" \
  && R -e "remotes::install_github('brentthorne/posterdown')" \
    ## Clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds



    


        
