-- I could import this maybe http://hackage.haskell.org/package/google-drive-0.4.1/docs/Network-Google-Api.html
-- I could import this maybe https://hackage.haskell.org/package/google-server-api
-- mike was here
import System.Process
import Text.Regex.Base
import Text.Regex.BACKEND

wget url = createProcess (proc "wget" ["-U", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36", "-q", url, "-O", "-"]) -- should dump the html from the url
whiteSpaceToPlusConverter string = map (\character -> if character==' ' then '+'; else character) string
uRLConverter searchString = whiteSpaceToPlusConverter searchString
duckduckgoConverter searchString = "duckduckgo.com/search?q=" ++ uRLConverter searchString -- convert a search string into a duckduckgo search url
duckduckgoSearcher searchString = wget(duckduckgoConverter searchString)
regexExtractor html searchString filterWord = (searchString =~ "[a-z]+") :: [String] --extract searchstring from html using regex
--https://regex101.com/
-- ^(https:\/\/|http:\/\/|)stackoverflow\.com.*
searchURLExtractor html searchString = regexExtractor html searchString --finds URLs *matching some TBD specification* in html

searchDuckduckgoForURLs searchString = searchURLExtractor(duckduckgoSearcher(searchString))
visitURLs uRLs = map wget uRLs
searchDuckduckgoAndVisitURLs searchString = visitURLs searchDuckduckgoForURLs searchString
searchDuckduckgoAndVisitStackoverflow
searchGoogleAndVisitStackoverflow
-- filter through to get the code snippits and terminal commands, anything formatted in some code block
getTopRatedAnswer -- filter for the top rated answer
filterForCodeBlocks -- filter for code blocks
filterForRun -- search for the word run

guessAtSolution errorMessage = filterForCodeBlocks(getTopRatedAnswer(searchDuckduckgoAndVisitStackoverflow(errorMessage)))
applySolutionSnippitToSloppyCode sloppyCode solutionSnippit = --TODO
attemptToCompile code = runGHC(code)
runSloppyCodeAndImproveByOneIteration sloppyCode = applySolutionSnippitToSloppyCode sloppyCode (guessAtSolution runGHC(sloppyCode))
codeCompilesWithoutError code = runGHC(code) == gHCSuccessMessage

fixCode code = if codeCompilesWithoutError code then code else fixCode (runSloppyCodeAndImproveByOneIteration code)

listenToUser -- listen to the user using SpeechToText (returns what the user said physically)
writeCode = listenToUser --and then write down users speech as a comment in the code file where the user specifies
                         --then ask if it looks good If NO then undo last proposed comment
                                                   --If YES then commit proposed comment
-- the strategy is to slowly convert the english comments from the user into haskell code
-- be like "what do you want to do?"
--         "how would that function work?"
           "What sorts of functions do you need?"
-- then keep running compiler and removing compiler errors until it can compile

fromCommentGuessFunctionName
fromFunctionNameGuessCode
fromCodeGuessComment

-- the key to get the drift on more and more track is to keep prompting the user to 
-- ask if the code is better than before or worse than before after each iteration
-- ask the user for input and keep asking the user, the compiler, google(stack overflow)
-- FORMAT THE CODE TO PASS LINTING

googleDesugarer -- take in a text file(string) and replace google searches with googlescraper(google search)
htmlResearcher -- take in a url and research string and output relevant text from the url
htmlDesugarer -- take in a text file(string) and replace urls with htmlresearcher(url) and examplefinder(htmlresearcher(url))
exampleFinder -- take in a url and research string and pull an example from the url of using the research string
compilerError -- take in a string and then run a compiler on that string and give back the error message
commentNamer -- take in a comment and give a name for that comment
haskellNamer -- take in haskell code and give it a name
stringToHaskellConverter -- take in a comment and convert to haskell code
nameToHaskellConverter -- take in a name and convert to haskell code
nameCommenter -- take in a name and provide a comment of what it does
compilerErrorGoogler :: String -> String -> String -> String -- InputFile -> ErrorMessage -> SearchEngine -> OutputFile
google :: String -> [String] -- google the error
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
