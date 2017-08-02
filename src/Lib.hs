{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( queryEC
    , module Types  
    ) where

import Data.Aeson
import qualified Data.Text as T
import Data.Time 
import Network.HTTP.Conduit (simpleHttp)
import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy.Char8 as BL

import Types

--------------------------------------------------------------------------------

endpoint :: T.Text
endpoint = "http://api.coindesk.com/v1/bpi/"


queryEC :: T.Text -> IO (Maybe T.Text)
queryEC query =  undefined -- fmap decode $ simpleHttp (T.unpack query)
