{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Etherchain
    ( queryEC
    , queryECT
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

queryECT :: T.Text -> IO (Either String ECHWrapper)
queryECT query = do
  vs <- simpleHttp $ T.unpack query
  return $ eitherDecode vs 

queryEC :: T.Text -> IO (Maybe T.Text)
queryEC query = fmap decode $ simpleHttp (T.unpack query)
