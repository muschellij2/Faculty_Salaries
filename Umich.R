rm( list = ls())
library(rvest)
library(plyr)
setwd("~/Dropbox/Packages/Faculty_Salaries/data")
years = 0:12
base_url = paste0("http://www.umsalary.info/deptsearch.php?")
urls = paste0(base_url, 
    "Dept=Biostatistics+Department", 
    "&Year=", years, "&Campus=0")
url = urls[1]

all_tabs = llply(urls, function(url){
    # function(url){
    html = url %>% read_html
    tabs = html %>% html_table
    tab = tabs[[3]]
    yr = colnames(tab)[1]
    colnames(tab) = tab[1,]
    tab$Year = gsub("Department Results for ", 
        "", yr)
    tab = tab[-1, ]
    tab$Name[ tab$Name %in% ""] = NA 
    return(tab)

}, .progress = "text")

all_df = do.call(rbind, all_tabs)

all_df = all_df %>% arrange(Name, desc(Year))

save(all_df, file ="UMich.rda")