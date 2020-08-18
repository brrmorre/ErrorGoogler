-- I could import this maybe http://hackage.haskell.org/package/google-drive-0.4.1/docs/Network-Google-Api.html
-- I could import this maybe https://hackage.haskell.org/package/google-server-api
-- mike was here
import System.Process

googlescraper :: String -> [String] -- take a string and google it and then give relevant urls/relevant text from the html

wget url = createProcess (proc "wget" ["-q", url, "-O", "-"]) -- should dump the html from the url

googledesugarer -- take in a text file(string) and replace google searches with googlescraper(google search)
htmlresearcher -- take in a url and research string and output relevant text from the url
htmldesugarer -- take in a text file(string) and replace urls with htmlresearcher(url) and examplefinder(htmlresearcher(url))
examplefinder -- take in a url and research string and pull an example from the url of using the research string
compilererror -- take in a string and then run a compiler on that string and give back the error message
stringnamer -- take in a string and give a name for that string
compilererrorgoogler :: String -> String -> String -- InputFile -> ErrorMessage -> OutputFile
google :: String -> [String] --google the error
--https://www.quora.com/Is-there-an-API-for-Google-search-results
--use wget?
--wget www.google.com
--wget -r www.google.com
--https://hackage.haskell.org/package/scalpel
--https://moz.com/blog/the-ultimate-guide-to-the-google-search-parameters
--wget http://www.google.com/search?q=query+goes+here
--compilererrorgoogler(InputFile, ErrorMessage, OutputFile)
--google(errorToURL(ErrorMessage)) where google is a wrapper for wget and errorToURL takes in the error as input and outputs a url
--https://hackage.haskell.org/package/scalpel-0.6.2/src/src/Text/HTML/Scalpel.hs
--https://hackage.haskell.org/package/http-wget
--https://hackage.haskell.org/package/scalpel-0.6.2/src/src/Text/HTML/Scalpel/Internal/Scrape/URL.hs
--https://hackage.haskell.org/package/http-conduit
--https://stackoverflow.com/questions/3470955/executing-a-system-command-in-haskell
--go on stack overflow
--apply fix to inputfile
--output fixed file

runtimeerror :: String -> String -> String -- InputFile -> ErrorMessage -> OutputFile
-- same stuff as above

oserrorgoogler :: String -> String -- ErrorMessage -> String of bash commands
--google the error
--go on on a forum and get the answer
--output the answer
