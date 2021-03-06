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

-- Module      : Network.AWS.CloudFront.ListCloudFrontOriginAccessIdentities
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

-- | List origin access identities.
--
-- <http://docs.aws.amazon.com/AmazonCloudFront/latest/APIReference/ListCloudFrontOriginAccessIdentities.html>
module Network.AWS.CloudFront.ListCloudFrontOriginAccessIdentities
    (
    -- * Request
      ListCloudFrontOriginAccessIdentities
    -- ** Request constructor
    , listCloudFrontOriginAccessIdentities
    -- ** Request lenses
    , lcfoaiMarker
    , lcfoaiMaxItems

    -- * Response
    , ListCloudFrontOriginAccessIdentitiesResponse
    -- ** Response constructor
    , listCloudFrontOriginAccessIdentitiesResponse
    -- ** Response lenses
    , lcfoairCloudFrontOriginAccessIdentityList
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.RestXML
import Network.AWS.CloudFront.Types
import qualified GHC.Exts

data ListCloudFrontOriginAccessIdentities = ListCloudFrontOriginAccessIdentities
    { _lcfoaiMarker   :: Maybe Text
    , _lcfoaiMaxItems :: Maybe Text
    } deriving (Eq, Ord, Read, Show)

-- | 'ListCloudFrontOriginAccessIdentities' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lcfoaiMarker' @::@ 'Maybe' 'Text'
--
-- * 'lcfoaiMaxItems' @::@ 'Maybe' 'Text'
--
listCloudFrontOriginAccessIdentities :: ListCloudFrontOriginAccessIdentities
listCloudFrontOriginAccessIdentities = ListCloudFrontOriginAccessIdentities
    { _lcfoaiMarker   = Nothing
    , _lcfoaiMaxItems = Nothing
    }

-- | Use this when paginating results to indicate where to begin in your list of
-- origin access identities. The results include identities in the list that
-- occur after the marker. To get the next page of results, set the Marker to
-- the value of the NextMarker from the current page's response (which is also
-- the ID of the last identity on that page).
lcfoaiMarker :: Lens' ListCloudFrontOriginAccessIdentities (Maybe Text)
lcfoaiMarker = lens _lcfoaiMarker (\s a -> s { _lcfoaiMarker = a })

-- | The maximum number of origin access identities you want in the response body.
lcfoaiMaxItems :: Lens' ListCloudFrontOriginAccessIdentities (Maybe Text)
lcfoaiMaxItems = lens _lcfoaiMaxItems (\s a -> s { _lcfoaiMaxItems = a })

newtype ListCloudFrontOriginAccessIdentitiesResponse = ListCloudFrontOriginAccessIdentitiesResponse
    { _lcfoairCloudFrontOriginAccessIdentityList :: CloudFrontOriginAccessIdentityList
    } deriving (Eq, Read, Show)

-- | 'ListCloudFrontOriginAccessIdentitiesResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lcfoairCloudFrontOriginAccessIdentityList' @::@ 'CloudFrontOriginAccessIdentityList'
--
listCloudFrontOriginAccessIdentitiesResponse :: CloudFrontOriginAccessIdentityList -- ^ 'lcfoairCloudFrontOriginAccessIdentityList'
                                             -> ListCloudFrontOriginAccessIdentitiesResponse
listCloudFrontOriginAccessIdentitiesResponse p1 = ListCloudFrontOriginAccessIdentitiesResponse
    { _lcfoairCloudFrontOriginAccessIdentityList = p1
    }

-- | The CloudFrontOriginAccessIdentityList type.
lcfoairCloudFrontOriginAccessIdentityList :: Lens' ListCloudFrontOriginAccessIdentitiesResponse CloudFrontOriginAccessIdentityList
lcfoairCloudFrontOriginAccessIdentityList =
    lens _lcfoairCloudFrontOriginAccessIdentityList
        (\s a -> s { _lcfoairCloudFrontOriginAccessIdentityList = a })

instance ToPath ListCloudFrontOriginAccessIdentities where
    toPath = const "/2014-10-21/origin-access-identity/cloudfront"

instance ToQuery ListCloudFrontOriginAccessIdentities where
    toQuery ListCloudFrontOriginAccessIdentities{..} = mconcat
        [ "Marker"   =? _lcfoaiMarker
        , "MaxItems" =? _lcfoaiMaxItems
        ]

instance ToHeaders ListCloudFrontOriginAccessIdentities

instance ToXMLRoot ListCloudFrontOriginAccessIdentities where
    toXMLRoot = const (namespaced ns "ListCloudFrontOriginAccessIdentities" [])

instance ToXML ListCloudFrontOriginAccessIdentities

instance AWSRequest ListCloudFrontOriginAccessIdentities where
    type Sv ListCloudFrontOriginAccessIdentities = CloudFront
    type Rs ListCloudFrontOriginAccessIdentities = ListCloudFrontOriginAccessIdentitiesResponse

    request  = get
    response = xmlResponse

instance FromXML ListCloudFrontOriginAccessIdentitiesResponse where
    parseXML x = ListCloudFrontOriginAccessIdentitiesResponse
        <$> x .@  "CloudFrontOriginAccessIdentityList"

instance AWSPager ListCloudFrontOriginAccessIdentities where
    page rq rs
        | stop (rs ^. lcfoairCloudFrontOriginAccessIdentityList . cfoailIsTruncated) = Nothing
        | otherwise = Just $ rq
            & lcfoaiMarker .~ rs ^. lcfoairCloudFrontOriginAccessIdentityList . cfoailNextMarker
