{-# LANGUAGE DeriveGeneric             #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE NoImplicitPrelude         #-}
{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE RecordWildCards           #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}

{-# OPTIONS_GHC -fno-warn-unused-binds #-}

-- Module      : Network.AWS.EC2.V2014_06_15.DescribeVolumeAttribute
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Describes the specified attribute of the specified volume. You can specify
-- only one attribute at a time. For more information about Amazon EBS
-- volumes, see Amazon EBS Volumes in the Amazon Elastic Compute Cloud User
-- Guide. Example This example describes the autoEnableIO attribute of the
-- volume vol-12345678.
-- https://ec2.amazonaws.com/?Action=DescribeVolumeAttribute
-- &amp;Attribute=autoEnableIO &amp;VolumeId=vol-12345678 &amp;AUTHPARAMS
-- &lt;DescribeVolumeAttributeResponse
-- xmlns="http://ec2.amazonaws.com/doc/2014-05-01/"&gt;
-- &lt;requestId&gt;5jkdf074-37ed-4004-8671-a78ee82bf1cbEXAMPLE&lt;/requestId&gt;
-- &lt;volumeId&gt;vol-12345678&lt;/volumeId&gt; &lt;autoEnableIO&gt;
-- &lt;value&gt;false&lt;/value&gt; &lt;/autoEnableIO&gt;
-- &lt;/DescribeVolumeAttributeResponse&gt; Example This example describes the
-- productCodes attribute of the volume vol-12345678.
-- https://ec2.amazonaws.com/?Action=DescribeVolumeAttribute
-- &amp;Attribute=productCodes &amp;VolumeId=vol-12345678 &amp;AUTHPARAMS
-- &lt;DescribeVolumeAttributeResponse
-- xmlns="http://ec2.amazonaws.com/doc/2014-05-01/"&gt;
-- &lt;requestId&gt;5jkdf074-37ed-4004-8671-a78ee82bf1cbEXAMPLE&lt;/requestId&gt;
-- &lt;volumeId&gt;vol-12345678&lt;/volumeId&gt; &lt;productCodes&gt;
-- &lt;item&gt;
-- &lt;productCode&gt;a1b2c3d4e5f6g7h8i9j10k11&lt;/productCode&gt;
-- &lt;type&gt;marketplace&lt;/type&gt; &lt;/item&gt; &lt;/productCodes&gt;
-- &lt;/DescribeVolumeAttributeResponse&gt;.
module Network.AWS.EC2.V2014_06_15.DescribeVolumeAttribute where

import Control.Lens.TH (makeLenses)
import Network.AWS.Request.Query
import Network.AWS.EC2.V2014_06_15.Types
import Network.AWS.Prelude

-- | Minimum specification for a 'DescribeVolumeAttribute' request.
describeVolumeAttribute :: Text -- ^ '_dvarVolumeId'
                        -> DescribeVolumeAttribute
describeVolumeAttribute p1 = DescribeVolumeAttribute
    { _dvarVolumeId = p1
    , _dvarDryRun = Nothing
    , _dvarAttribute = Nothing
    }

data DescribeVolumeAttribute = DescribeVolumeAttribute
    { _dvarVolumeId :: Text
      -- ^ The ID of the volume.
    , _dvarDryRun :: Maybe Bool
      -- ^ 
    , _dvarAttribute :: Maybe VolumeAttributeName
      -- ^ The instance attribute.
    } deriving (Show, Generic)

makeLenses ''DescribeVolumeAttribute

instance ToQuery DescribeVolumeAttribute where
    toQuery = genericQuery def

data DescribeVolumeAttributeResponse = DescribeVolumeAttributeResponse
    { _dvasAutoEnableIO :: Maybe AttributeBooleanValue
      -- ^ The state of autoEnableIO attribute.
    , _dvasProductCodes :: [ProductCode]
      -- ^ A list of product codes.
    , _dvasVolumeId :: Maybe Text
      -- ^ The ID of the volume.
    } deriving (Show, Generic)

makeLenses ''DescribeVolumeAttributeResponse

instance FromXML DescribeVolumeAttributeResponse where
    fromXMLOptions = xmlOptions

instance AWSRequest DescribeVolumeAttribute where
    type Sv DescribeVolumeAttribute = EC2
    type Rs DescribeVolumeAttribute = DescribeVolumeAttributeResponse

    request = post "DescribeVolumeAttribute"
    response _ = xmlResponse
