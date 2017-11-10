FROM andrewheiss/tidyverse-rstanarm
LABEL maintainer="Ignacio Martinez <ignacio@protonmail.com>"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ## for rJava
    default-jdk \
    ## used to build rJava and other packages
    libbz2-dev \
    libicu-dev \
    liblzma-dev \
    ## V8
    libv8-3.14-dev


## configure JAVA and install rJava package
RUN R CMD javareconf
RUN R -e "install.packages('rJava', dependencies = TRUE, repos='https://cran.rstudio.com/')"

# Install Packages
RUN install2.r --error \
        secret \
        drat \
        V8 \
        && R -e "drat::addRepo(account = 'Ignacio', alturl = 'https://drat.ignacio.website/'); \
        install.packages(c('IMSecrets', 'IMWatson', 'themeIM', 'yourls', 'IMBayesian'));" \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds


