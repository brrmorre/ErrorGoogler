-- I could import this maybe http://hackage.haskell.org/package/google-drive-0.4.1/docs/Network-Google-Api.html
-- I could import this maybe https://hackage.haskell.org/package/google-server-api
-- mike was here
import System.Process

googleScraper :: String -> [String] -- take a string and google it and then give relevant urls/relevant text from the html

wget url = createProcess (proc "wget" ["-U", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36", "-q", url, "-O", "-"]) -- should dump the html from the url
whiteSpaceToPlusConverter string = map (\character -> if character==' ' then '+'; else character) string
uRLConverter searchString = whiteSpaceToPlusConverter searchString
duckduckgoConverter searchString = "duckduckgo.com/search?q=" ++ uRLConverter searchString -- convert a search string into a duckduckgo search url
duckduckgoSearcher searchString = wget(duckduckgoConverter searchString)
regexExtractor searchString = (searchString =~ "/(stackexchange+)\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?") :: [String]--extract searchstring from html using regex
searchURLExtractor html = regexExtractor html--finds URLs *matching some TBD specification* in html
googleDesugarer -- take in a text file(string) and replace google searches with googlescraper(google search)
htmlResearcher -- take in a url and research string and output relevant text from the url
htmlDesugarer -- take in a text file(string) and replace urls with htmlresearcher(url) and examplefinder(htmlresearcher(url))
exampleFinder -- take in a url and research string and pull an example from the url of using the research string
compilerError -- take in a string and then run a compiler on that string and give back the error message
stringNamer -- take in a string and give a name for that string
nameToHaskellConverter -- take in a name and convert to haskell
nameCommenter -- take in a name and provide a comment of what it does
compilerErrorGoogler :: String -> String -> String -- InputFile -> ErrorMessage -> OutputFile
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
