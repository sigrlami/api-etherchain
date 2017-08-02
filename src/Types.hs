{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE DeriveAnyClass  #-}
{-# LANGUAGE TemplateHaskell #-}

module Types where

import           Data.Aeson
import           Data.Text
import           GHC.Generics
import           Data.Aeson.TH

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
    , trIsContractTx :: Maybe Bool
    , trBlockHash    :: T.Text
    , trParentHash   :: T.Text
    , trTxIndex      :: Maybe T.Text
    , trGasUsed      :: Int
    , trType         :: T.Text  
    } deriving (Generic, Show)

-- | Bitcoing price index
data ECHWrapper =
  ECHWrapper
  { ewStatus  :: BPITime 
  , ewData    :: [ECHTransaction]
  } deriving (Generic, Show)

instance FromJSON ECHWrapper where
  parseJSON (Object v) =
    ECHWrapper
      <$> v .:  "status"
      <*> v .:? "data"
  parseJSON _          = mzero


instance FromJSON ECHTransaction where
  parseJSON (Object v) =
    ECHTransaction
      <$> v .:  "hash"
      <*> v .:? "sender"
      <*> v .:? "recipient"
      <*> v .:? "accountNonce"
      <*> v .:? "price"
      <*> v .:? "gasLimit"
      <*> v .:? "amount"
      <*> v .:? "block_id"
      <*> v .:? "time"
      <*> v .:? "newContract"
      <*> v .:? "isContractTx"
      <*> v .:? "blockHash"
      <*> v .:? "parentHash"
      <*> v .:? "txIndex"
      <*> v .:? "gasUsed"
      <*> v .:? "type"
  parseJSON _          = mzero
