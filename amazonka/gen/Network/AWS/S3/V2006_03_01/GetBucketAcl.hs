{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.S3.V2006_03_01.GetBucketAcl
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Gets the access control policy for the bucket.
module Network.AWS.S3.V2006_03_01.GetBucketAcl where

import           Control.Applicative
import           Data.ByteString      (ByteString)
import           Data.Default
import           Data.HashMap.Strict  (HashMap)
import           Data.Maybe
import           Data.Monoid
import           Data.Text            (Text)
import qualified Data.Text            as Text
import           GHC.Generics
import           Network.AWS.Data
import           Network.AWS.Response
import           Network.AWS.Types    hiding (Error)
import           Network.AWS.Request.RestS3
import           Network.AWS.S3.V2006_03_01.Types
import           Network.HTTP.Client  (Response)
import           Prelude              hiding (head)

-- | Default GetBucketAcl request.
getBucketAcl :: BucketName -- ^ '_gbarBucket'
             -> GetBucketAcl
getBucketAcl p1 = GetBucketAcl
    { _gbarBucket = p1
    }

data GetBucketAcl = GetBucketAcl
    { _gbarBucket :: BucketName
    } deriving (Show, Generic)

instance ToPath GetBucketAcl where
    toPath GetBucketAcl{..} = mconcat
        [ "/"
        , toBS _gbarBucket
        ]

instance ToQuery GetBucketAcl

instance ToHeaders GetBucketAcl

instance ToBody GetBucketAcl

instance AWSRequest GetBucketAcl where
    type Sv GetBucketAcl = S3

    request  = get
    response = xmlResponse

data instance Rs GetBucketAcl = GetBucketAclResponse
    { _gbaoGrants :: [Grant]
      -- ^ A list of grants.
    , _gbaoOwner :: Maybe Owner
    } deriving (Show, Generic)

instance FromXML (Rs GetBucketAcl) where
    fromXMLOptions = xmlOptions
