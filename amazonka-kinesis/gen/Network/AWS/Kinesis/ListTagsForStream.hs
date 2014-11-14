{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}

{-# OPTIONS_GHC -w                      #-}

-- Module      : Network.AWS.Kinesis.ListTagsForStream
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Lists the tags for the specified Amazon Kinesis stream.
module Network.AWS.Kinesis.ListTagsForStream
    (
    -- * Request
      ListTagsForStream
    -- ** Request constructor
    , listTagsForStream
    -- ** Request lenses
    , ltfsExclusiveStartTagKey
    , ltfsLimit
    , ltfsStreamName

    -- * Response
    , ListTagsForStreamResponse
    -- ** Response constructor
    , listTagsForStreamResponse
    -- ** Response lenses
    , ltfsrHasMoreTags
    , ltfsrTags
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Kinesis.Types
import qualified GHC.Exts

data ListTagsForStream = ListTagsForStream
    { _ltfsExclusiveStartTagKey :: Maybe Text
    , _ltfsLimit                :: Maybe Natural
    , _ltfsStreamName           :: Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'ListTagsForStream' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ltfsExclusiveStartTagKey' @::@ 'Maybe' 'Text'
--
-- * 'ltfsLimit' @::@ 'Maybe' 'Natural'
--
-- * 'ltfsStreamName' @::@ 'Text'
--
listTagsForStream :: Text -- ^ 'ltfsStreamName'
                  -> ListTagsForStream
listTagsForStream p1 = ListTagsForStream
    { _ltfsStreamName           = p1
    , _ltfsExclusiveStartTagKey = Nothing
    , _ltfsLimit                = Nothing
    }

-- | The key to use as the starting point for the list of tags. If this
-- parameter is set, ListTagsForStream gets all tags that occur after
-- ExclusiveStartTagKey.
ltfsExclusiveStartTagKey :: Lens' ListTagsForStream (Maybe Text)
ltfsExclusiveStartTagKey =
    lens _ltfsExclusiveStartTagKey
        (\s a -> s { _ltfsExclusiveStartTagKey = a })

-- | The number of tags to return. If this number is less than the total
-- number of tags associated with the stream, HasMoreTags is set to true. To
-- list additional tags, set ExclusiveStartTagKey to the last key in the
-- response.
ltfsLimit :: Lens' ListTagsForStream (Maybe Natural)
ltfsLimit = lens _ltfsLimit (\s a -> s { _ltfsLimit = a })

-- | The name of the stream.
ltfsStreamName :: Lens' ListTagsForStream Text
ltfsStreamName = lens _ltfsStreamName (\s a -> s { _ltfsStreamName = a })

instance ToPath ListTagsForStream where
    toPath = const "/"

instance ToQuery ListTagsForStream where
    toQuery = const mempty

instance ToHeaders ListTagsForStream

instance ToBody ListTagsForStream where
    toBody = toBody . encode . _ltfsStreamName

data ListTagsForStreamResponse = ListTagsForStreamResponse
    { _ltfsrHasMoreTags :: Bool
    , _ltfsrTags        :: [Tag]
    } deriving (Eq, Show, Generic)

-- | 'ListTagsForStreamResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ltfsrHasMoreTags' @::@ 'Bool'
--
-- * 'ltfsrTags' @::@ ['Tag']
--
listTagsForStreamResponse :: Bool -- ^ 'ltfsrHasMoreTags'
                          -> ListTagsForStreamResponse
listTagsForStreamResponse p1 = ListTagsForStreamResponse
    { _ltfsrHasMoreTags = p1
    , _ltfsrTags        = mempty
    }

-- | If set to true, more tags are available. To request additional tags, set
-- ExclusiveStartTagKey to the key of the last tag returned.
ltfsrHasMoreTags :: Lens' ListTagsForStreamResponse Bool
ltfsrHasMoreTags = lens _ltfsrHasMoreTags (\s a -> s { _ltfsrHasMoreTags = a })

-- | A list of tags associated with StreamName, starting with the first tag
-- after ExclusiveStartTagKey and up to the specified Limit.
ltfsrTags :: Lens' ListTagsForStreamResponse [Tag]
ltfsrTags = lens _ltfsrTags (\s a -> s { _ltfsrTags = a })

instance AWSRequest ListTagsForStream where
    type Sv ListTagsForStream = Kinesis
    type Rs ListTagsForStream = ListTagsForStreamResponse

    request  = post
    response = jsonResponse $ \h o -> ListTagsForStreamResponse
        <$> o .: "HasMoreTags"
        <*> o .: "Tags"
