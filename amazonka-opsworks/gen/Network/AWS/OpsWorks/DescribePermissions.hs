{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}

{-# OPTIONS_GHC -w                      #-}

-- Module      : Network.AWS.OpsWorks.DescribePermissions
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Describes the permissions for a specified stack. Required Permissions: To
-- use this action, an IAM user must have a Manage permissions level for the
-- stack, or an attached policy that explicitly grants permissions. For more
-- information on user permissions, see Managing User Permissions.
module Network.AWS.OpsWorks.DescribePermissions
    (
    -- * Request
      DescribePermissions
    -- ** Request constructor
    , describePermissions
    -- ** Request lenses
    , dpIamUserArn
    , dpStackId

    -- * Response
    , DescribePermissionsResponse
    -- ** Response constructor
    , describePermissionsResponse
    -- ** Response lenses
    , dprPermissions
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.OpsWorks.Types
import qualified GHC.Exts

data DescribePermissions = DescribePermissions
    { _dpIamUserArn :: Maybe Text
    , _dpStackId    :: Maybe Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'DescribePermissions' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dpIamUserArn' @::@ 'Maybe' 'Text'
--
-- * 'dpStackId' @::@ 'Maybe' 'Text'
--
describePermissions :: DescribePermissions
describePermissions = DescribePermissions
    { _dpIamUserArn = Nothing
    , _dpStackId    = Nothing
    }

-- | The user's IAM ARN. For more information about IAM ARNs, see Using
-- Identifiers.
dpIamUserArn :: Lens' DescribePermissions (Maybe Text)
dpIamUserArn = lens _dpIamUserArn (\s a -> s { _dpIamUserArn = a })

-- | The stack ID.
dpStackId :: Lens' DescribePermissions (Maybe Text)
dpStackId = lens _dpStackId (\s a -> s { _dpStackId = a })

instance ToPath DescribePermissions where
    toPath = const "/"

instance ToQuery DescribePermissions where
    toQuery = const mempty

instance ToHeaders DescribePermissions

instance ToBody DescribePermissions where
    toBody = toBody . encode . _dpIamUserArn

newtype DescribePermissionsResponse = DescribePermissionsResponse
    { _dprPermissions :: [Permission]
    } deriving (Eq, Show, Generic, Monoid, Semigroup)

instance GHC.Exts.IsList DescribePermissionsResponse where
    type Item DescribePermissionsResponse = Permission

    fromList = DescribePermissionsResponse . GHC.Exts.fromList
    toList   = GHC.Exts.toList . _dprPermissions

-- | 'DescribePermissionsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dprPermissions' @::@ ['Permission']
--
describePermissionsResponse :: DescribePermissionsResponse
describePermissionsResponse = DescribePermissionsResponse
    { _dprPermissions = mempty
    }

-- | An array of Permission objects that describe the stack permissions. If
-- the request object contains only a stack ID, the array contains a
-- Permission object with permissions for each of the stack IAM ARNs. If the
-- request object contains only an IAM ARN, the array contains a Permission
-- object with permissions for each of the user's stack IDs. If the request
-- contains a stack ID and an IAM ARN, the array contains a single
-- Permission object with permissions for the specified stack and IAM ARN.
dprPermissions :: Lens' DescribePermissionsResponse [Permission]
dprPermissions = lens _dprPermissions (\s a -> s { _dprPermissions = a })

instance AWSRequest DescribePermissions where
    type Sv DescribePermissions = OpsWorks
    type Rs DescribePermissions = DescribePermissionsResponse

    request  = post
    response = jsonResponse $ \h o -> DescribePermissionsResponse
        <$> o .: "Permissions"
