rm(list = ls())
library(jsonlite)
outfile = "col_data.js"
# library(downloader)
# col_data = "http://i.cdn.turner.com/money/calculator/pf/cost-of-living/js/data.js"
# download(col_data, destfile = outfile)

r = readLines(outfile)
vars = grep("^var", r)
states = paste0("[", 
    paste(  r[(vars[1]+1):(vars[2] - 3)], 
        collapse = "\n"),
    "]")
states_df = fromJSON(states)

col = paste0("[{", 
    paste(  r[(vars[2]+1):(length(r) - 1)], 
        collapse = "\n"),
    "}]")
col_df = fromJSON(col)

save(states, col_df, file = "Cost_of_Living.rda")