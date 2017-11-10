FROM rocker/tidyverse
LABEL maintainer="Ignacio Martinez <ignacio@protonmail.com>"
# Install secret
RUN install2.r --error \
        secret \
        drat \
        && R -e "drat::addRepo(account = 'Ignacio', alturl = 'https://drat.ignacio.website/'); \
        install.packages(c('IMSecrets', 'IMWatson', 'themeIM', 'yourls'));" \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds