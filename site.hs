--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
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
    tags <- buildTags "posts/*" (fromCapture "tags/*.html")

    -- Eine Seite pro Tag: tags/<tag>.html
    tagsRules tags $ \tag pat -> do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll pat
            let tagCtx =
                    constField "title" ("Posts tagged \"" ++ tag ++ "\"") <>
                    listField "posts" (postCtxWithTags tags) (return posts) <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/post-list.html" tagCtx
                >>= loadAndApplyTemplate "templates/default.html"   tagCtx
                >>= relativizeUrls

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
            >>= loadAndApplyTemplate "templates/post.html"    (postCtxWithTags tags)
            >>= loadAndApplyTemplate "templates/default.html" (postCtxWithTags tags)
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" (postCtxWithTags tags) (return posts) <>
                    constField "title" "Archives" <>
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
                    listField "posts" (postCtxWithTags tags) (return posts) <>
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" <>
    defaultContext

postCtxWithTags :: Tags -> Context String
postCtxWithTags tags = tagsField "tags" tags <> postCtx
