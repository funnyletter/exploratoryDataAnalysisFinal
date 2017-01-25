url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

NEI <- NULL
SCC <- NULL

# If the files aren't already in the directory, download and unzip them
if (!file.exists('Source_Classification_Code.rds') | !file.exists('summarySCC_PM25.rds')) {
  download.file(url = url, destfile = "dldata.zip", method = "auto")
  unzip(zipfile = "dldata.zip")
}
  
# Open data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')


