--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll

import           Text.Pandoc.Options (WriterOptions (..), HTMLMathMethod (..))
import           Skylighting.Types (SyntaxMap)
import           Skylighting.Parser (addSyntaxDefinition, parseSyntaxDefinition)

--------------------------------------------------------------------------------
-- Pandoc-Compiler mit MathJax-Auszeichnung für Formeln
-- und zusätzlicher Syntax für Lean-Codeblöcke (syntax/lean4.xml)
mathCompiler :: SyntaxMap -> Compiler (Item String)
mathCompiler syntaxMap =
    pandocCompilerWith
        defaultHakyllReaderOptions
        defaultHakyllWriterOptions
            { writerHTMLMathMethod = MathJax ""
            , writerSyntaxMap      = syntaxMap
            }

-- Die Standard-Syntaxen von Pandoc plus Lean
loadSyntaxMap :: IO SyntaxMap
loadSyntaxMap = do
    lean <- parseSyntaxDefinition "syntax/lean4.xml"
    case lean of
        Left err  -> fail ("syntax/lean4.xml: " ++ err)
        Right syn -> return $
            addSyntaxDefinition syn (writerSyntaxMap defaultHakyllWriterOptions)

--------------------------------------------------------------------------------
main :: IO ()
main = do
  syntaxMap <- loadSyntaxMap
  hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.rst", "contact.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do

        route $ setExtension "html"
        compile $ mathCompiler syntaxMap
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls


    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    tags <- buildTags "posts/*" (fromCapture "tags/*.html")
    tagsField "tags" tags `mappend`
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext
