{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}

{-# OPTIONS_GHC -w                      #-}

-- Module      : Network.AWS.OpsWorks.DescribeServiceErrors
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Describes AWS OpsWorks service errors. Required Permissions: To use this
-- action, an IAM user must have a Show, Deploy, or Manage permissions level
-- for the stack, or an attached policy that explicitly grants permissions.
-- For more information on user permissions, see Managing User Permissions.
module Network.AWS.OpsWorks.DescribeServiceErrors
    (
    -- * Request
      DescribeServiceErrors
    -- ** Request constructor
    , describeServiceErrors
    -- ** Request lenses
    , dseInstanceId
    , dseServiceErrorIds
    , dseStackId

    -- * Response
    , DescribeServiceErrorsResponse
    -- ** Response constructor
    , describeServiceErrorsResponse
    -- ** Response lenses
    , dserServiceErrors
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.OpsWorks.Types
import qualified GHC.Exts

data DescribeServiceErrors = DescribeServiceErrors
    { _dseInstanceId      :: Maybe Text
    , _dseServiceErrorIds :: [Text]
    , _dseStackId         :: Maybe Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'DescribeServiceErrors' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dseInstanceId' @::@ 'Maybe' 'Text'
--
-- * 'dseServiceErrorIds' @::@ ['Text']
--
-- * 'dseStackId' @::@ 'Maybe' 'Text'
--
describeServiceErrors :: DescribeServiceErrors
describeServiceErrors = DescribeServiceErrors
    { _dseStackId         = Nothing
    , _dseInstanceId      = Nothing
    , _dseServiceErrorIds = mempty
    }

-- | The instance ID. If you use this parameter, DescribeServiceErrors returns
-- descriptions of the errors associated with the specified instance.
dseInstanceId :: Lens' DescribeServiceErrors (Maybe Text)
dseInstanceId = lens _dseInstanceId (\s a -> s { _dseInstanceId = a })

-- | An array of service error IDs. If you use this parameter,
-- DescribeServiceErrors returns descriptions of the specified errors.
-- Otherwise, it returns a description of every error.
dseServiceErrorIds :: Lens' DescribeServiceErrors [Text]
dseServiceErrorIds =
    lens _dseServiceErrorIds (\s a -> s { _dseServiceErrorIds = a })

-- | The stack ID. If you use this parameter, DescribeServiceErrors returns
-- descriptions of the errors associated with the specified stack.
dseStackId :: Lens' DescribeServiceErrors (Maybe Text)
dseStackId = lens _dseStackId (\s a -> s { _dseStackId = a })

instance ToPath DescribeServiceErrors where
    toPath = const "/"

instance ToQuery DescribeServiceErrors where
    toQuery = const mempty

instance ToHeaders DescribeServiceErrors

instance ToBody DescribeServiceErrors where
    toBody = toBody . encode . _dseStackId

newtype DescribeServiceErrorsResponse = DescribeServiceErrorsResponse
    { _dserServiceErrors :: [ServiceError]
    } deriving (Eq, Show, Generic, Monoid, Semigroup)

instance GHC.Exts.IsList DescribeServiceErrorsResponse where
    type Item DescribeServiceErrorsResponse = ServiceError

    fromList = DescribeServiceErrorsResponse . GHC.Exts.fromList
    toList   = GHC.Exts.toList . _dserServiceErrors

-- | 'DescribeServiceErrorsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dserServiceErrors' @::@ ['ServiceError']
--
describeServiceErrorsResponse :: DescribeServiceErrorsResponse
describeServiceErrorsResponse = DescribeServiceErrorsResponse
    { _dserServiceErrors = mempty
    }

-- | An array of ServiceError objects that describe the specified service
-- errors.
dserServiceErrors :: Lens' DescribeServiceErrorsResponse [ServiceError]
dserServiceErrors =
    lens _dserServiceErrors (\s a -> s { _dserServiceErrors = a })

instance AWSRequest DescribeServiceErrors where
    type Sv DescribeServiceErrors = OpsWorks
    type Rs DescribeServiceErrors = DescribeServiceErrorsResponse

    request  = post
    response = jsonResponse $ \h o -> DescribeServiceErrorsResponse
        <$> o .: "ServiceErrors"
