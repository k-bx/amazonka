{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}

{-# OPTIONS_GHC -w                      #-}

-- Module      : Network.AWS.Config.DescribeConfigurationRecorderStatus
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Returns the current status of the specified configuration recorder. If a
-- configuration recorder is not specified, this action returns the status of
-- all configuration recorder associated with the account.
module Network.AWS.Config.DescribeConfigurationRecorderStatus
    (
    -- * Request
      DescribeConfigurationRecorderStatus
    -- ** Request constructor
    , describeConfigurationRecorderStatus
    -- ** Request lenses
    , dcrsConfigurationRecorderNames

    -- * Response
    , DescribeConfigurationRecorderStatusResponse
    -- ** Response constructor
    , describeConfigurationRecorderStatusResponse
    -- ** Response lenses
    , dcrsrConfigurationRecordersStatus
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Config.Types
import qualified GHC.Exts

newtype DescribeConfigurationRecorderStatus = DescribeConfigurationRecorderStatus
    { _dcrsConfigurationRecorderNames :: [Text]
    } deriving (Eq, Ord, Show, Generic, Monoid, Semigroup)

instance GHC.Exts.IsList DescribeConfigurationRecorderStatus where
    type Item DescribeConfigurationRecorderStatus = Text

    fromList = DescribeConfigurationRecorderStatus . GHC.Exts.fromList
    toList   = GHC.Exts.toList . _dcrsConfigurationRecorderNames

-- | 'DescribeConfigurationRecorderStatus' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dcrsConfigurationRecorderNames' @::@ ['Text']
--
describeConfigurationRecorderStatus :: DescribeConfigurationRecorderStatus
describeConfigurationRecorderStatus = DescribeConfigurationRecorderStatus
    { _dcrsConfigurationRecorderNames = mempty
    }

-- | The name(s) of the configuration recorder. If the name is not specified,
-- the action returns the current status of all the configuration recorders
-- associated with the account.
dcrsConfigurationRecorderNames :: Lens' DescribeConfigurationRecorderStatus [Text]
dcrsConfigurationRecorderNames =
    lens _dcrsConfigurationRecorderNames
        (\s a -> s { _dcrsConfigurationRecorderNames = a })

instance ToPath DescribeConfigurationRecorderStatus where
    toPath = const "/"

instance ToQuery DescribeConfigurationRecorderStatus where
    toQuery = const mempty

instance ToHeaders DescribeConfigurationRecorderStatus

instance ToBody DescribeConfigurationRecorderStatus where
    toBody = toBody . encode . _dcrsConfigurationRecorderNames

newtype DescribeConfigurationRecorderStatusResponse = DescribeConfigurationRecorderStatusResponse
    { _dcrsrConfigurationRecordersStatus :: [ConfigurationRecorderStatus]
    } deriving (Eq, Show, Generic, Monoid, Semigroup)

instance GHC.Exts.IsList DescribeConfigurationRecorderStatusResponse where
    type Item DescribeConfigurationRecorderStatusResponse = ConfigurationRecorderStatus

    fromList = DescribeConfigurationRecorderStatusResponse . GHC.Exts.fromList
    toList   = GHC.Exts.toList . _dcrsrConfigurationRecordersStatus

-- | 'DescribeConfigurationRecorderStatusResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dcrsrConfigurationRecordersStatus' @::@ ['ConfigurationRecorderStatus']
--
describeConfigurationRecorderStatusResponse :: DescribeConfigurationRecorderStatusResponse
describeConfigurationRecorderStatusResponse = DescribeConfigurationRecorderStatusResponse
    { _dcrsrConfigurationRecordersStatus = mempty
    }

-- | A list that contains status of the specified recorders.
dcrsrConfigurationRecordersStatus :: Lens' DescribeConfigurationRecorderStatusResponse [ConfigurationRecorderStatus]
dcrsrConfigurationRecordersStatus =
    lens _dcrsrConfigurationRecordersStatus
        (\s a -> s { _dcrsrConfigurationRecordersStatus = a })

instance AWSRequest DescribeConfigurationRecorderStatus where
    type Sv DescribeConfigurationRecorderStatus = Config
    type Rs DescribeConfigurationRecorderStatus = DescribeConfigurationRecorderStatusResponse

    request  = post
    response = jsonResponse $ \h o -> DescribeConfigurationRecorderStatusResponse
        <$> o .: "ConfigurationRecordersStatus"
