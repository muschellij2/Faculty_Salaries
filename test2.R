# from http://stackoverflow.com/questions/15853204/how-to-login-and-then-download-a-file-from-aspx-web-pages-with-r
library(RCurl)
curl = getCurlHandle()
# curlSetOpt(cookiejar = 'cookies.txt', 
#     followlocation = TRUE, autoreferer = TRUE, 
#     curl = curl)
html <- getURL(
    'http://extra.twincities.com/car/salaries/default.aspx', 
    curl = curl)
viewstate <- as.character(sub('.*id="__VIEWSTATE" value="([0-9a-zA-Z+/=]*).*', '\\1', html))


x = POST('http://extra.twincities.com/car/salaries/default.aspx',
    body = list(submit = 'Submit',
        GovtDropDown = "U of M",
        DataYearDrop = "2014      "))

x2 = postForm('http://extra.twincities.com/car/salaries/default.aspx',
    submit = 'Submit',
        GovtDropDown = "U of M",
        DataYearDrop = "2014      ")