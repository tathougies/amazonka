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

-- Module      : Network.AWS.Route53.ListGeoLocations
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

-- | To retrieve a list of supported geo locations, send a 'GET' request to the '2013-04-01/geolocations' resource. The response to this request includes a 'GeoLocationDetailsList'
-- element with zero, one, or multiple 'GeoLocationDetails' child elements. The
-- list is sorted by country code, and then subdivision code, followed by
-- continents at the end of the list.
--
-- By default, the list of geo locations is displayed on a single page. You
-- can control the length of the page that is displayed by using the 'MaxItems'
-- parameter. If the list is truncated, 'IsTruncated' will be set to /true/ and a
-- combination of 'NextContinentCode, NextCountryCode, NextSubdivisionCode' will
-- be populated. You can pass these as parameters to 'StartContinentCode,StartCountryCode, StartSubdivisionCode' to control the geo location that the
-- list begins with.
--
-- <http://docs.aws.amazon.com/Route53/latest/APIReference/API_ListGeoLocations.html>
module Network.AWS.Route53.ListGeoLocations
    (
    -- * Request
      ListGeoLocations
    -- ** Request constructor
    , listGeoLocations
    -- ** Request lenses
    , lglMaxItems
    , lglStartContinentCode
    , lglStartCountryCode
    , lglStartSubdivisionCode

    -- * Response
    , ListGeoLocationsResponse
    -- ** Response constructor
    , listGeoLocationsResponse
    -- ** Response lenses
    , lglrGeoLocationDetailsList
    , lglrIsTruncated
    , lglrMaxItems
    , lglrNextContinentCode
    , lglrNextCountryCode
    , lglrNextSubdivisionCode
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.RestXML
import Network.AWS.Route53.Types
import qualified GHC.Exts

data ListGeoLocations = ListGeoLocations
    { _lglMaxItems             :: Maybe Text
    , _lglStartContinentCode   :: Maybe Text
    , _lglStartCountryCode     :: Maybe Text
    , _lglStartSubdivisionCode :: Maybe Text
    } deriving (Eq, Ord, Read, Show)

-- | 'ListGeoLocations' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lglMaxItems' @::@ 'Maybe' 'Text'
--
-- * 'lglStartContinentCode' @::@ 'Maybe' 'Text'
--
-- * 'lglStartCountryCode' @::@ 'Maybe' 'Text'
--
-- * 'lglStartSubdivisionCode' @::@ 'Maybe' 'Text'
--
listGeoLocations :: ListGeoLocations
listGeoLocations = ListGeoLocations
    { _lglStartContinentCode   = Nothing
    , _lglStartCountryCode     = Nothing
    , _lglStartSubdivisionCode = Nothing
    , _lglMaxItems             = Nothing
    }

-- | The maximum number of geo locations you want in the response body.
lglMaxItems :: Lens' ListGeoLocations (Maybe Text)
lglMaxItems = lens _lglMaxItems (\s a -> s { _lglMaxItems = a })

-- | The first continent code in the lexicographic ordering of geo locations that
-- you want the 'ListGeoLocations' request to list. For non-continent geo
-- locations, this should be null.
--
-- Valid values: 'AF' | 'AN' | 'AS' | 'EU' | 'OC' | 'NA' | 'SA'
--
-- Constraint: Specifying 'ContinentCode' with either 'CountryCode' or 'SubdivisionCode' returns an 'InvalidInput' error.
lglStartContinentCode :: Lens' ListGeoLocations (Maybe Text)
lglStartContinentCode =
    lens _lglStartContinentCode (\s a -> s { _lglStartContinentCode = a })

-- | The first country code in the lexicographic ordering of geo locations that
-- you want the 'ListGeoLocations' request to list.
--
-- The default geo location uses a '*' for the country code. All other country
-- codes follow the ISO 3166 two-character code.
lglStartCountryCode :: Lens' ListGeoLocations (Maybe Text)
lglStartCountryCode =
    lens _lglStartCountryCode (\s a -> s { _lglStartCountryCode = a })

-- | The first subdivision code in the lexicographic ordering of geo locations
-- that you want the 'ListGeoLocations' request to list.
--
-- Constraint: Specifying 'SubdivisionCode' without 'CountryCode' returns an 'InvalidInput' error.
lglStartSubdivisionCode :: Lens' ListGeoLocations (Maybe Text)
lglStartSubdivisionCode =
    lens _lglStartSubdivisionCode (\s a -> s { _lglStartSubdivisionCode = a })

data ListGeoLocationsResponse = ListGeoLocationsResponse
    { _lglrGeoLocationDetailsList :: List "GeoLocationDetails" GeoLocationDetails
    , _lglrIsTruncated            :: Bool
    , _lglrMaxItems               :: Text
    , _lglrNextContinentCode      :: Maybe Text
    , _lglrNextCountryCode        :: Maybe Text
    , _lglrNextSubdivisionCode    :: Maybe Text
    } deriving (Eq, Read, Show)

-- | 'ListGeoLocationsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lglrGeoLocationDetailsList' @::@ ['GeoLocationDetails']
--
-- * 'lglrIsTruncated' @::@ 'Bool'
--
-- * 'lglrMaxItems' @::@ 'Text'
--
-- * 'lglrNextContinentCode' @::@ 'Maybe' 'Text'
--
-- * 'lglrNextCountryCode' @::@ 'Maybe' 'Text'
--
-- * 'lglrNextSubdivisionCode' @::@ 'Maybe' 'Text'
--
listGeoLocationsResponse :: Bool -- ^ 'lglrIsTruncated'
                         -> Text -- ^ 'lglrMaxItems'
                         -> ListGeoLocationsResponse
listGeoLocationsResponse p1 p2 = ListGeoLocationsResponse
    { _lglrIsTruncated            = p1
    , _lglrMaxItems               = p2
    , _lglrGeoLocationDetailsList = mempty
    , _lglrNextContinentCode      = Nothing
    , _lglrNextCountryCode        = Nothing
    , _lglrNextSubdivisionCode    = Nothing
    }

-- | A complex type that contains information about the geo locations that are
-- returned by the request.
lglrGeoLocationDetailsList :: Lens' ListGeoLocationsResponse [GeoLocationDetails]
lglrGeoLocationDetailsList =
    lens _lglrGeoLocationDetailsList
        (\s a -> s { _lglrGeoLocationDetailsList = a })
            . _List

-- | A flag that indicates whether there are more geo locations to be listed. If
-- your results were truncated, you can make a follow-up request for the next
-- page of results by using the values included in the 'ListGeoLocationsResponse$NextContinentCode', 'ListGeoLocationsResponse$NextCountryCode' and 'ListGeoLocationsResponse$NextSubdivisionCode' elements.
--
-- Valid Values: 'true' | 'false'
lglrIsTruncated :: Lens' ListGeoLocationsResponse Bool
lglrIsTruncated = lens _lglrIsTruncated (\s a -> s { _lglrIsTruncated = a })

-- | The maximum number of records you requested. The maximum value of 'MaxItems' is
-- 100.
lglrMaxItems :: Lens' ListGeoLocationsResponse Text
lglrMaxItems = lens _lglrMaxItems (\s a -> s { _lglrMaxItems = a })

-- | If the results were truncated, the continent code of the next geo location in
-- the list. This element is present only if 'ListGeoLocationsResponse$IsTruncated'
-- is true and the next geo location to list is a continent location.
lglrNextContinentCode :: Lens' ListGeoLocationsResponse (Maybe Text)
lglrNextContinentCode =
    lens _lglrNextContinentCode (\s a -> s { _lglrNextContinentCode = a })

-- | If the results were truncated, the country code of the next geo location in
-- the list. This element is present only if 'ListGeoLocationsResponse$IsTruncated'
-- is true and the next geo location to list is not a continent location.
lglrNextCountryCode :: Lens' ListGeoLocationsResponse (Maybe Text)
lglrNextCountryCode =
    lens _lglrNextCountryCode (\s a -> s { _lglrNextCountryCode = a })

-- | If the results were truncated, the subdivision code of the next geo location
-- in the list. This element is present only if 'ListGeoLocationsResponse$IsTruncated' is true and the next geo location has a subdivision.
lglrNextSubdivisionCode :: Lens' ListGeoLocationsResponse (Maybe Text)
lglrNextSubdivisionCode =
    lens _lglrNextSubdivisionCode (\s a -> s { _lglrNextSubdivisionCode = a })

instance ToPath ListGeoLocations where
    toPath = const "/2013-04-01/geolocations"

instance ToQuery ListGeoLocations where
    toQuery ListGeoLocations{..} = mconcat
        [ "maxitems"             =? _lglMaxItems
        , "startcontinentcode"   =? _lglStartContinentCode
        , "startcountrycode"     =? _lglStartCountryCode
        , "startsubdivisioncode" =? _lglStartSubdivisionCode
        ]

instance ToHeaders ListGeoLocations

instance ToXMLRoot ListGeoLocations where
    toXMLRoot = const (namespaced ns "ListGeoLocations" [])

instance ToXML ListGeoLocations

instance AWSRequest ListGeoLocations where
    type Sv ListGeoLocations = Route53
    type Rs ListGeoLocations = ListGeoLocationsResponse

    request  = get
    response = xmlResponse

instance FromXML ListGeoLocationsResponse where
    parseXML x = ListGeoLocationsResponse
        <$> x .@? "GeoLocationDetailsList" .!@ mempty
        <*> x .@  "IsTruncated"
        <*> x .@  "MaxItems"
        <*> x .@? "NextContinentCode"
        <*> x .@? "NextCountryCode"
        <*> x .@? "NextSubdivisionCode"
