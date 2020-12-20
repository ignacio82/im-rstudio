FROM rocker/verse:latest
LABEL maintainer="Ignacio Martinez <ignacio@protonmail.com>"

# Make ~/.R
RUN mkdir -p $HOME/.R 

# $HOME doesn't exist in the COPY shell, so be explicit
COPY R/Makevars root/.R/Makevars 

#RUN echo "rstan::rstan_options(auto_write = TRUE)\n" >> /home/rstudio/.Rprofile \
#    && echo "options(mc.cores = parallel::detectCores())\n" >> /home/rstudio/.Rprofile

RUN apt-get update \
   && apt-get -y --no-install-recommends install \
      apt-utils \
      ed \
      libnlopt-dev \
## V8
    libv8-dev \
## sodium
    libsodium-dev \
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
        ggridges \
        optmatch \
        zip \
        blogdown \
        tictoc \
        remotes \
        remoter \
        sodium  \
        bayesplot \
        gt \
        Synth \
        gsynth \
        panelView \
        svglite \
        tidylog \
        fst \
        cowplot \
        gtable \
        lemon \
        grid \
        gridExtra \
        openintro \
        scales \
        && R -e "drat::addRepo(account = 'Ignacio', alturl = 'https://drat.ignacio.website/'); \
        install.packages(c('IMSecrets', 'themeIM'))" \
  && installGithub.r \
        ignacio82/vizdraws \
  && R -e "remotes::install_github('rstudio/pagedown')" \
  && R -e "install.packages(c('cmdstanr','posterior'), repos = c('https://mc-stan.org/r-packages/', getOption('repos')))" \
    ## Clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
