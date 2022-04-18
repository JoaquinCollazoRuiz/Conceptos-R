#******************************************************************************#
#                                                                              #
#                       Session 3 - Logs Analysis                              #
#                                                                              #                                                                            #
#******************************************************************************#

# ------------------------------------------------------------------------------
# Load packages ----------------------------------------------------------------
# ------------------------------------------------------------------------------

# Instalar packages
install.packages("dplyr")

library("dplyr")
library("stringr")
install.packages("rjson")
library("rjson")
library("ggplot2")

setwd("G:/")
getwd()
# Set working directory
mywd <- "./datosMDM/"
dir.create(mywd)
setwd(mywd)
getwd()

# ------------------------------------------------------------------------------
# Download data ----------------------------------------------------------------
# ------------------------------------------------------------------------------

logs_url <- "https://github.com/rfuentesf/Data-Driven-Security/raw/master/apache-samples.rar"
compressed_logs_filename <- basename(logs_url)
dirname(logs_url)

download.file(url = logs_url, destfile = compressed_logs_filename, mode = "wb");

# Works on OS with unrar command, if not run add PATH C:\Program Files\WinRAR
ruta <- "unrar.exe x -r -o- *.rar "
shell(ruta)

ruta <- "unrar.exe x -r -o- *.rar"
shell(ruta)

# Load CSV file into DF / RStudio Button
dataset <- read.csv("./access_log/access_log",
                    sep = " ",
                    quote = '\"',
                    header = FALSE,
                    stringsAsFactors = F)

# We can add nrows = 500 to read.csv in case the file is very large
# and so with a test subset is enough
# to then be able to run it on another more powerful machine 

access_log <- read.table("./access_log/access_log", 
                         quote = "\"", 
                         comment.char = "")

# Inspect DF rows / cols
nrow(dataset)
ncol(dataset)
head(dataset)
sapply(dataset, class)
summary(dataset)

# ------------------------------------------------------------------------------
# Tidy DF ----------------------------------------------------------------------
# ------------------------------------------------------------------------------

# Set column names
colnames(dataset)

column_names <- c("ip", "basic_auth_user", "basic_auth_group",
                  "data", "tx",  "resource",
                  "return_code", "resp_size")
column_names
colnames(dataset) <- column_names
colnames(dataset)

# Convert column v8 to integer
dataset$resp_size <- as.integer(dataset$resp_size)

dataset$return_code <- as.factor(dataset$return_code)
levels(dataset$return_code)

dataset$basic_auth_group[dataset$basic_auth_group == "-"] <- NA
dataset$basic_auth_user[dataset$basic_auth_user == "-"] <- NA

sapply(dataset, class)
summary(dataset)

# 'Resources' column
dataset$resource

# List with column 'resource' 
http_res_prot <- stringr::str_split(dataset$resource, pattern = " ")

# Add column with first, second, third element from latest list
dataset$http_req_type <- sapply(http_res_prot, '[', 1)
dataset$req_resource <- sapply(http_res_prot, '[', 2)
dataset$http_version <- sapply(http_res_prot, '[', 3)

# Remove 'resource' column
dataset$resource <- NULL

# Set correct http request type to factor
dataset$http_req_type <- as.factor(dataset$http_req_type)
levels(dataset$http_req_type)


# ------------------------------------------------------------------------------
# Exploration ------------------------------------------------------------------
# ------------------------------------------------------------------------------

# Total unique users in sample log
length(unique(dataset$ip))

# View frequency of IPs
t1 <- table(dataset$ip)
t1 <- t1[order(t1,decreasing = TRUE)]
t1

head(t1)

# Show Ip requests
dataset[dataset$ip == "64.242.88.10",]
dataset[dataset$ip == "64.242.88.10","return_code"]

# Info for ip that resulted in Unauthorized
suspicious <- dataset[dataset$return_code == "401",c("ip", "return_code")]
suspicious_table <- table(suspicious$ip)
suspicious_table
top_suspicious_ip <- suspicious_table[head(order(suspicious_table,decreasing = TRUE), n = 1)]
top_suspicious_ip

top_suspicious_ip <- suspicious_table[head(order(suspicious_table,decreasing = TRUE), n = 2)]
top_suspicious_ip

# We try to find out information about that IP
top_suspicious_ip <- suspicious_table[head(order(suspicious_table,decreasing = TRUE), n = 1)]
url <- paste('http://ip-api.com/json/', names(top_suspicious_ip), sep = '')
url
ip_info <- fromJSON(readLines(url, warn = FALSE))
ip_info
View(ip_info)

# Count most common HTTP request types
request_types <- dplyr::count(dataset, http_req_type)
request_types

# Count most common requested resources
resources <- dplyr::count(dataset, req_resource)
resources

# Count most common requested resources (sort)
?dplyr::count
resources <- dplyr::count(dataset, req_resource, sort = T)
resources

# Count most requested resources (images filtered)
dataset.filtered <- dplyr::filter(dataset,
                                  !grepl(pattern = ".*[png|jpg|gif|ico]$",
                                  x = req_resource))

resources_filtered <- dplyr::count(dataset.filtered,
                                   req_resource,
                                   sort = T)

resources_filtered

# View responses 
count_return_code <- dplyr::count(dataset.filtered, return_code)
count_return_code

# Barplot and Ggplot
barplot(count_return_code$n,
        names.arg = count_return_code$return_code,
        main = "Response Code Count")

ggplot(count_return_code, aes(x=return_code, y=n)) +
  geom_bar(stat = "identity")

# ------------------------------------------------------------------------------
# Websites to represent data / types
# ------------------------------------------------------------------------------

# https://www.r-graph-gallery.com/
# https://www.data-to-viz.com/

