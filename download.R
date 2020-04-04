url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile1 <- "destfile.zip"

if(!file.exists(destfile1)) {
        download.file(url1, 
                      destfile = destfile1, 
                      method = "curl")
        unzip(destfile1, exdir = ".")
}
