rm(list=ls())
library(RCurl)
library(httr)
library(XML)
# http://stackoverflow.com/questions/30513616/posting-data-using-xml-with-r
url1 <- 'http://transparency.ct.gov/html/getEntityTable.asp'

xml_text <- c(
    '<REQUEST><ENTITY_TYPE>UOC</ENTITY_TYPE><FISCAL_YEAR>2014</FISCAL_YEAR></REQUEST>'
    )
h = basicTextGatherer()
httpheader=c("Content-Type"=
    "application/x-www-form-urlencoded")

result <- curlPerform(url = url1,
  httpheader=httpheader,
  postfields=xml_text,
  writefunction = h$update,
  verbose = TRUE
)
result
h$value()

r = POST(url1, 
    config = add_headers(httpheader),
    body = list(onClick="retrieveFiscalYearExp()"),
    encode = "form")

library(rdom)
url = "http://transparency.ct.gov/html/searchPayroll.asp"
rd = rdom(url)