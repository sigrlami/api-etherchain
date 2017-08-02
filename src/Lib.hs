{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( queryEC
    , module Types  
    ) where

import           Data.Aeson
import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Text as T
import           Data.Time
import           Network.HTTP.Conduit (simpleHttp)

import           Types

--------------------------------------------------------------------------------

endpoint :: T.Text
endpoint = "https://etherchain.org/api/"

getHistory :: T.Text -> Int -> T.Text
getHistory acc page = T.concat [endpoint, "account/", acc, "/tx/", (T.pack $ show $ page)]

queryEC :: T.Text -> IO (Maybe T.Text)
queryEC query = fmap decode $ simpleHttp (T.unpack query)
