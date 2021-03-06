{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE FlexibleInstances   #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RecordWildCards     #-}

module Types where

import           Data.Aeson
import           Control.Monad (mzero)
import           Control.Applicative
import qualified Data.ByteString.Char8      as B
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Text as T
import           Data.Time
import           GHC.Generics

--------------------------------------------------------------------------------

data ECHTransaction =
  ECHTransaction
    { trHash         :: T.Text
    , trSender       :: T.Text
    , trRecipient    :: T.Text
    , trAccountNonce :: T.Text
    , trPrice        :: Int
    , trGasLimit     :: Int
    , trAmount       :: Int
    , trBlock_id     :: Int
    , trTime         :: UTCTime
    , trNewContract  :: Int 
    , trIsContractTx :: Maybe T.Text
    , trBlockHash    :: T.Text
    , trParentHash   :: T.Text
    , trTxIndex      :: Maybe Int
    , trGasUsed      :: Int
    , trType         :: T.Text  
    } deriving (Show)

data ECHWrapper =
  ECHWrapper
  { ewStatus  :: Int 
  , ewData    :: [ECHTransaction]
  } deriving (Show)

instance FromJSON ECHWrapper where
  parseJSON = withObject "wrapper" $ \o -> do
    st <- o .: "status" 
    dt <- o .: "data" 
    return $ ECHWrapper st dt

instance FromJSON ECHTransaction where
  parseJSON = withObject "tender" $ \o -> do
    hs <- o .: "hash" 
    se <- o .: "sender" 
    rc <- o .: "recipient" 
    ac <- o .: "accountNonce" 
    pr <- o .: "price" 
    gl <- o .: "gasLimit" 
    am <- o .: "amount" 
    bi <- o .: "block_id" 
    tm <- o .: "time" 
    nc <- o .: "newContract" 
    ic <- o .: "isContractTx" 
    bh <- o .: "blockHash" 
    ph <- o .: "parentHash" 
    ti <- o .: "txIndex" 
    gu <- o .: "gasUsed" 
    ty <- o .: "type" 
    return $ ECHTransaction hs se rc ac pr gl am bi tm nc ic bh ph ti gu ty
