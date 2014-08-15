{-# LANGUAGE DeriveGeneric             #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE NoImplicitPrelude         #-}
{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE RecordWildCards           #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}

{-# OPTIONS_GHC -fno-warn-unused-binds #-}

-- Module      : Network.AWS.S3.V2006_03_01.PutBucketLogging
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Set the logging parameters for a bucket and to specify permissions for who
-- can view and modify the logging parameters. To set the logging status of a
-- bucket, you must be the bucket owner.
module Network.AWS.S3.V2006_03_01.PutBucketLogging where

import Control.Lens.TH (makeLenses)
import Network.AWS.Request.RestS3
import Network.AWS.S3.V2006_03_01.Types
import Network.AWS.Prelude

-- | Minimum specification for a 'PutBucketLogging' request.
putBucketLogging :: BucketLoggingStatus -- ^ '_pblrBucketLoggingStatus'
                 -> BucketName -- ^ '_pblrBucket'
                 -> PutBucketLogging
putBucketLogging p1 p2 = PutBucketLogging
    { _pblrBucketLoggingStatus = p1
    , _pblrBucket = p2
    , _pblrContentMD5 = Nothing
    }

data PutBucketLogging = PutBucketLogging
    { _pblrBucketLoggingStatus :: BucketLoggingStatus
    , _pblrBucket :: BucketName
    , _pblrContentMD5 :: Maybe Text
    } deriving (Show, Generic)

makeLenses ''PutBucketLogging

instance ToPath PutBucketLogging where
    toPath PutBucketLogging{..} = mconcat
        [ "/"
        , toBS _pblrBucket
        ]

instance ToQuery PutBucketLogging where
    toQuery PutBucketLogging{..} = mconcat
        [ "logging"
        ]

instance ToHeaders PutBucketLogging where
    toHeaders PutBucketLogging{..} = concat
        [ "Content-MD5" =: _pblrContentMD5
        ]

instance ToBody PutBucketLogging where
    toBody = toBody . encodeXML . _pblrBucketLoggingStatus

data PutBucketLoggingResponse = PutBucketLoggingResponse
    deriving (Eq, Show, Generic)

makeLenses ''PutBucketLoggingResponse

instance AWSRequest PutBucketLogging where
    type Sv PutBucketLogging = S3
    type Rs PutBucketLogging = PutBucketLoggingResponse

    request = put
    response _ = nullaryResponse PutBucketLoggingResponse
