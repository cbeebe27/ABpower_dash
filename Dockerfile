FROM rocker/shiny-verse:latest
RUN apt-get update && apt-get install -y git

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libcurl4-gnutls-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libv8-dev \
    libcairo2-dev \
    libxt-dev

RUN R -e "install.packages(c('tidyverse', 'sf', 'plotly', 'maps', 'rvest', 'leaflet', 'shinythemes'), dependencies = TRUE, repos = 'https://packagemanager.rstudio.com/cran/latest')"

# Install from GitHub repository
RUN git clone https://github.com/cbeebe27/ABpower_dash.git /srv/shiny-server/ABpower_dash

# Make the Shiny app available at port 3838
EXPOSE 3838

# Run the app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/ABpower_dash/', host = '0.0.0.0', port = 3838)"]
