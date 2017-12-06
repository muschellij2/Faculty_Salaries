rm(list=ls())
library(rvest)
library(plyr)
library(dplyr)
years = 2006:2014
base_url = paste0("http://", 
    "db.desmoinesregister.com", 
    "/state-salaries-for-iowa/")
search_terms = paste0("searchterms%5Bcol3%5D=", 
    "&searchterms%5Bcol2", 
    "%5D=University&searchterms%5Bcol11%5D=", 
    years)
years_url = paste0(base_url, 
    "?", search_terms)

all_n_pages = laply(years_url, function(url){
    html = url %>% read_html
    n_pages = xml2::xml_find_one(html, 
        '//a[@title="Last Page"]')
    last_page = xml_attr(n_pages, "href")
    last_page = gsub(".*page=(.*)&searchterm.*",
        "\\1", 
        last_page)
    last_page = last_page %>% 
        strsplit(split = "&") %>% first %>% first
    as.numeric(last_page)
}, .progress = "text")

df = data.frame(url = years_url,
    n_pages = all_n_pages, 
    search_term = search_terms,
    stringsAsFactors = FALSE)

constructor = function(url, 
    search_term, page_num = 1){
    paste0(base_url, "page=", page_num, 
        "&", search_term)
}

# tabs = mlply(df, function(url, n_pages, 
#     search_term){
# for (iyear in seq_along(years)){

    iyear = 9
    outrda = paste0("Iowa_", years[iyear], 
            ".rda")
    if (!file.exists(outrda)) {
        url = df$url[iyear]
        search_term = df$search_term[iyear]
        n_pages = df$n_pages[iyear]
        all_pages = constructor(url, 
            search_term,
            page_num = seq(n_pages))

        all_year_tabs = vector(mode = "list",
            length = n_pages)
        for (iurl in seq(n_pages)) {
            u = all_pages[iurl]
            html = u %>% read_html
            tab = html %>% html_table %>% first
            all_year_tabs[[iurl]] = tab
            message(paste0(iurl, " of ", 
                n_pages))
        }
        save(all_year_tabs, 
            file = outrda)        
    }


    # html = url %>% read_html
    # print(all_pages)
    # }, .progress = "text")


# }