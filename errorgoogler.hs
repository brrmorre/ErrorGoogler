{-# LANGUAGE FlexibleContexts #-}
-- I could import this maybe http://hackage.haskell.org/package/google-drive-0.4.1/docs/Network-Google-Api.html
-- I could import this maybe https://hackage.haskell.org/package/google-server-api
-- mike was here
import System.Environment
import System.Process
import Text.Regex.TDFA
import Text.Regex.TDFA ()
import System.IO
import Data.Char

dropInvalids :: [Char] -> [Char]
dropInvalids = filter (\x -> isLetter x || isDigit x || isSymbol x)

prependHaskell inputString = "Haskell+" ++ inputString
appendStackoverflow inputString = inputString ++ "+Stackoverflow"
appendDuckduckgoJunk inputString = inputString ++ "&t=ht&ia=web"
prependDuckduckgoJunk inputString = "duckduckgo.com/?q=" ++ inputString
prependGoogleJunk inputString = "google.com/search?q=" ++ inputString

main = do
    args <- getArgs
    case args of 
      [file] -> do
        inputCode <- readFile file
        putStr inputCode
        putStrLn "Im gonna now attempt to compile this code for you <3"
        (_, Just ghchout, Just ghcherror, _) <- runGHC file
        errorMessage <- hGetContents ghcherror
        putStrLn errorMessage
        putStrLn (googleConverter(errorMessage))
        --(_, Just ddghout, _, _) <- duckduckgoSearcher(errorMessage)
        --searchResultDDGHTML <- hGetContents ddghout
        (_, Just googlehout, _, _) <- googleSearcher(errorMessage)
        searchResultGoogleHTML <- hGetContents googlehout
        (_, Just stackoverflowhout, _, _) <- wget (head(tail(head(stackoverflowURLFinder(searchResultGoogleHTML)))))
        stackHTML <- hGetContents stackoverflowhout
        --putStrLn stackHTML
        --print (codeBlockFinder stackHTML)
        print (head(acceptedAnswerFinder stackHTML))
        --remove question from HTML because that has bad code
        --remove metadata, look for class="answer accepted-answer"
        --look for <code></code> blocks inside the accepted-answer
        --copy paste them into the code file

wget url = createProcess (proc "wget" ["-U", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36", "-q", url, "-O", "-"]){ std_out = CreatePipe } -- should dump the html from the url
--wget url = createProcess (proc "wget" ["-U", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36", "-q", url, "-o", "search.html"]) -- should dump the html from the url
whiteSpaceToPlusConverter string = map (\character -> if character==' ' then '+'; else character) string
uRLConverter searchString = appendStackoverflow(prependHaskell(drop 24 (dropInvalids(whiteSpaceToPlusConverter(searchString)))))
duckduckgoConverter searchString = prependDuckduckgoJunk(uRLConverter(searchString)) -- convert a search string into a duckduckgo search url
duckduckgoSearcher searchString = wget(duckduckgoConverter searchString)
googleConverter searchString = prependGoogleJunk(uRLConverter(searchString)) -- convert a search string into a duckduckgo search url
googleSearcher searchString = wget(googleConverter searchString)
stackoverflowURLFinder html = (html =~ ("((https://|http://)?([^./]+[.])?stackoverflow[.]com[^\"]*)(\")" :: String)) :: [[String]]
codeBlockFinder html = (html =~ ("<code>(.|\n)*</code>" :: String)) :: [[String]]
acceptedAnswerFinder html = (html =~ ("class=\"answer accepted-answer\"(.|\n)*</div>" :: String)) :: [[String]]
grep searchWord filename = createProcess(proc "grep" [searchWord,filename])
runGHC filePath = createProcess (proc "ghc" [filePath]){std_out = CreatePipe, std_err = CreatePipe}
--searchDuckduckgoForStackoverflowURLs searchString = stackoverflowURLFinder(duckduckgoSearcher(searchString))

--main = print ((duckduckgoSearcher "stackoverflow") =~ "[a-z]+" :: String)

--google keywords like example or stackoverflow or tutorial
--search stackoverflow and code base for examples of working code that uses the stuff that is incorrectly used as a result of the error message
--ask the user if the example is a good example
--copy paste example and make it fit into problem area.
--figure out the form of the solution and then change your own code to replicate the form of the solution
--use HEURISTICS to edit the code around the problem area and see if it compiles.
--the editing of the code guess to see if it compiles should atleast try to make it look like it knows what its doing
--it should know the form of the correct code and then try to modify its own code to try to replicate the form of the correct code
--we dont need to know what we are doing as long as it compiles. LOL

--regexExtractor :: IO(Maybe GHC.IO.Handle.Types.Handle,
--                              Maybe GHC.IO.Handle.Types.Handle, Maybe GHC.IO.Handle.Types.Handle,
--                              ProcessHandle) -> String
--regexExtractor html = html =~ "*stackoverflow*" --extract searchstring from html using regex
--https://regex101.com/
-- ^(https:\/\/|http:\/\/|)stackoverflow\.com.*
-- searchURLExtractor html = regexExtractor html --finds URLs *matching some TBD specification* in html

-- visitURLs uRLs = map wget uRLs
-- searchDuckduckgoAndVisitURLs searchString = visitURLs(searchDuckduckgoForURLs searchString)
-- searchDuckduckgoAndVisitStackoverflow
-- searchGoogleAndVisitStackoverflow
-- filter through to get the code snippits and terminal commands, anything formatted in some code block
-- getTopRatedAnswer -- filter for the top rated answer
-- filterForCodeBlocks -- filter for code blocks
-- filterForRun -- search for the word run

-- guessAtSolution errorMessage = filterForCodeBlocks(getTopRatedAnswer(searchDuckduckgoAndVisitStackoverflow(errorMessage)))
-- applySolutionSnippitToSloppyCode sloppyCode solutionSnippit = --TODO
-- runGHC code = createProcess (proc "ghc" [code])
-- runSloppyCodeAndImproveByOneIteration sloppyCode = applySolutionSnippitToSloppyCode sloppyCode (guessAtSolution runGHC(sloppyCode))
-- codeCompilesWithoutError code = runGHC(code) == gHCSuccessMessage

-- fixCode code = if codeCompilesWithoutError code then code else fixCode (runSloppyCodeAndImproveByOneIteration code)

--listenToUser -- listen to the user using SpeechToText (returns what the user said physically)
--writeCode = listenToUser --and then write down users speech as a comment in the code file where the user specifies
                         --then ask if it looks good If NO then undo last proposed comment
                                                   --If YES then commit proposed comment
-- the strategy is to slowly convert the english comments from the user into haskell code
-- be like "So, what functionality do you want to add now?" when bored (this adds a comment) (then commit to git after each iteration LOL!!!!)
--         add support for deleting comments
--         "So... How do you want to implement this comment? I can suggest some names..."
--         "how would that function work?"
-- When the error message is "This thing isnt defined, then ask the user if they wanna define it"
--           "What sorts of functions do you need?"
-- then keep running compiler and removing compiler errors until it can compile

--fromCommentGuessFunctionName
--fromFunctionNameGuessCode
--fromCodeGuessComment

-- the key to get the drift on more and more track is to keep prompting the user to 
-- ask if the code is better than before or worse than before after each iteration
-- ask the user for input and keep asking the user, the compiler, google(stack overflow)
-- AUTO FORMAT THE CODE TO BE PRETTY FOR ME. ILL MAKE THE FORMATTER BETTER IF IT SCREWS UP.
-- define an english-like formal language that can desugar to haskell function calls.
-- the machine takes the comment and can guess a formal language statement that is similar to what the comment specifies
-- the machine can also keep questioning how the user wants to do something

-- ask the user for coarse idea of what they want the program to do or the feature they wanna add
-- keep fleshing out the feature more and more by creating functions. It keeps prompting the user on how
-- exactly they want to implement key parts of the idea
-- Go downwards in abstraction
-- idea -> implementation
-- go on stack overflow to flesh out the details of the implentation and correct errors

-- if stack overflow isnt one of the top searches, like the first one or the second one. Then this means the search is bad.
-- We never should go past the first 5 links provided by google.

--closestWellFormedTerm term -- from a comment use edit distance to try to acquire a well formed term.
-- Return the well formed term with the smallest edit distance from the comment

--googleDesugarer -- take in a text file(string) and replace google searches with googlescraper(google search)
--htmlResearcher -- take in a url and research string and output relevant text from the url
--htmlDesugarer -- take in a text file(string) and replace urls with htmlresearcher(url) and examplefinder(htmlresearcher(url))
--exampleFinder -- take in a url and research string and pull an example from the url of using the research string
--compilerError -- take in a string and then run a compiler on that string and give back the error message
--commentNamer -- take in a comment and give a name for that comment
--haskellNamer -- take in haskell code and give it a name
--stringToHaskellConverter -- take in a comment and convert to haskell code
--nameToHaskellConverter -- take in a name and convert to haskell code
--nameCommenter -- take in a name and provide a comment of what it does
--compilerErrorGoogler :: String -> String -> String -> String -- InputFile -> ErrorMessage -> SearchEngine -> OutputFile
--google :: String -> [String] -- google the error
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

--runtimeerror :: String -> String -> String -- InputFile -> ErrorMessage -> OutputFile
-- same stuff as above

--oserrorgoogler :: String -> String -- ErrorMessage -> String of bash commands
--google the error
--go on on a forum and get the answer
--output the answer
