{-# LANGUAGE DataKinds                   #-}
{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving  #-}
{-# LANGUAGE LambdaCase                  #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.SNS.ListSubscriptionsByTopic
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | Returns a list of the subscriptions to a specific topic. Each call returns a
-- limited list of subscriptions, up to 100. If there are more subscriptions, a 'NextToken' is also returned. Use the 'NextToken' parameter in a new 'ListSubscriptionsByTopic' call to get further results.
--
-- <http://docs.aws.amazon.com/sns/latest/api/API_ListSubscriptionsByTopic.html>
module Network.AWS.SNS.ListSubscriptionsByTopic
    (
    -- * Request
      ListSubscriptionsByTopic
    -- ** Request constructor
    , listSubscriptionsByTopic
    -- ** Request lenses
    , lsbtNextToken
    , lsbtTopicArn

    -- * Response
    , ListSubscriptionsByTopicResponse
    -- ** Response constructor
    , listSubscriptionsByTopicResponse
    -- ** Response lenses
    , lsbtrNextToken
    , lsbtrSubscriptions
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.SNS.Types
import qualified GHC.Exts

data ListSubscriptionsByTopic = ListSubscriptionsByTopic
    { _lsbtNextToken :: Maybe Text
    , _lsbtTopicArn  :: Text
    } deriving (Eq, Ord, Read, Show)

-- | 'ListSubscriptionsByTopic' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lsbtNextToken' @::@ 'Maybe' 'Text'
--
-- * 'lsbtTopicArn' @::@ 'Text'
--
listSubscriptionsByTopic :: Text -- ^ 'lsbtTopicArn'
                         -> ListSubscriptionsByTopic
listSubscriptionsByTopic p1 = ListSubscriptionsByTopic
    { _lsbtTopicArn  = p1
    , _lsbtNextToken = Nothing
    }

-- | Token returned by the previous 'ListSubscriptionsByTopic' request.
lsbtNextToken :: Lens' ListSubscriptionsByTopic (Maybe Text)
lsbtNextToken = lens _lsbtNextToken (\s a -> s { _lsbtNextToken = a })

-- | The ARN of the topic for which you wish to find subscriptions.
lsbtTopicArn :: Lens' ListSubscriptionsByTopic Text
lsbtTopicArn = lens _lsbtTopicArn (\s a -> s { _lsbtTopicArn = a })

data ListSubscriptionsByTopicResponse = ListSubscriptionsByTopicResponse
    { _lsbtrNextToken     :: Maybe Text
    , _lsbtrSubscriptions :: List "member" Subscription
    } deriving (Eq, Read, Show)

-- | 'ListSubscriptionsByTopicResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lsbtrNextToken' @::@ 'Maybe' 'Text'
--
-- * 'lsbtrSubscriptions' @::@ ['Subscription']
--
listSubscriptionsByTopicResponse :: ListSubscriptionsByTopicResponse
listSubscriptionsByTopicResponse = ListSubscriptionsByTopicResponse
    { _lsbtrSubscriptions = mempty
    , _lsbtrNextToken     = Nothing
    }

-- | Token to pass along to the next 'ListSubscriptionsByTopic' request. This
-- element is returned if there are more subscriptions to retrieve.
lsbtrNextToken :: Lens' ListSubscriptionsByTopicResponse (Maybe Text)
lsbtrNextToken = lens _lsbtrNextToken (\s a -> s { _lsbtrNextToken = a })

-- | A list of subscriptions.
lsbtrSubscriptions :: Lens' ListSubscriptionsByTopicResponse [Subscription]
lsbtrSubscriptions =
    lens _lsbtrSubscriptions (\s a -> s { _lsbtrSubscriptions = a })
        . _List

instance ToPath ListSubscriptionsByTopic where
    toPath = const "/"

instance ToQuery ListSubscriptionsByTopic where
    toQuery ListSubscriptionsByTopic{..} = mconcat
        [ "NextToken" =? _lsbtNextToken
        , "TopicArn"  =? _lsbtTopicArn
        ]

instance ToHeaders ListSubscriptionsByTopic

instance AWSRequest ListSubscriptionsByTopic where
    type Sv ListSubscriptionsByTopic = SNS
    type Rs ListSubscriptionsByTopic = ListSubscriptionsByTopicResponse

    request  = post "ListSubscriptionsByTopic"
    response = xmlResponse

instance FromXML ListSubscriptionsByTopicResponse where
    parseXML = withElement "ListSubscriptionsByTopicResult" $ \x -> ListSubscriptionsByTopicResponse
        <$> x .@? "NextToken"
        <*> x .@? "Subscriptions" .!@ mempty

instance AWSPager ListSubscriptionsByTopic where
    page rq rs
        | stop (rs ^. lsbtrNextToken) = Nothing
        | otherwise = (\x -> rq & lsbtNextToken ?~ x)
            <$> (rs ^. lsbtrNextToken)
