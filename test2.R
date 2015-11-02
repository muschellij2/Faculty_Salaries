# from http://stackoverflow.com/questions/15853204/how-to-login-and-then-download-a-file-from-aspx-web-pages-with-r
library(RCurl)
curl = getCurlHandle()
curlSetOpt(cookiejar = 'cookies.txt', followlocation = TRUE, autoreferer = TRUE, curl = curl)