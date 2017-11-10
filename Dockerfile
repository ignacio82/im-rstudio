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
&& install2.r --error \
StanHeaders rstan
        
        




