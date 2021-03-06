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

-- Module      : Network.AWS.CloudSearch.CreateDomain
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

-- | Creates a new search domain. For more information, see Creating a Search
-- Domain in the /Amazon CloudSearch Developer Guide/.
--
-- <http://docs.aws.amazon.com/cloudsearch/latest/developerguide/API_CreateDomain.html>
module Network.AWS.CloudSearch.CreateDomain
    (
    -- * Request
      CreateDomain
    -- ** Request constructor
    , createDomain
    -- ** Request lenses
    , cdDomainName

    -- * Response
    , CreateDomainResponse
    -- ** Response constructor
    , createDomainResponse
    -- ** Response lenses
    , cdrDomainStatus
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.CloudSearch.Types
import qualified GHC.Exts

newtype CreateDomain = CreateDomain
    { _cdDomainName :: Text
    } deriving (Eq, Ord, Read, Show, Monoid, IsString)

-- | 'CreateDomain' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cdDomainName' @::@ 'Text'
--
createDomain :: Text -- ^ 'cdDomainName'
             -> CreateDomain
createDomain p1 = CreateDomain
    { _cdDomainName = p1
    }

-- | A name for the domain you are creating. Allowed characters are a-z
-- (lower-case letters), 0-9, and hyphen (-). Domain names must start with a
-- letter or number and be at least 3 and no more than 28 characters long.
cdDomainName :: Lens' CreateDomain Text
cdDomainName = lens _cdDomainName (\s a -> s { _cdDomainName = a })

newtype CreateDomainResponse = CreateDomainResponse
    { _cdrDomainStatus :: Maybe DomainStatus
    } deriving (Eq, Read, Show)

-- | 'CreateDomainResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cdrDomainStatus' @::@ 'Maybe' 'DomainStatus'
--
createDomainResponse :: CreateDomainResponse
createDomainResponse = CreateDomainResponse
    { _cdrDomainStatus = Nothing
    }

cdrDomainStatus :: Lens' CreateDomainResponse (Maybe DomainStatus)
cdrDomainStatus = lens _cdrDomainStatus (\s a -> s { _cdrDomainStatus = a })

instance ToPath CreateDomain where
    toPath = const "/"

instance ToQuery CreateDomain where
    toQuery CreateDomain{..} = mconcat
        [ "DomainName" =? _cdDomainName
        ]

instance ToHeaders CreateDomain

instance AWSRequest CreateDomain where
    type Sv CreateDomain = CloudSearch
    type Rs CreateDomain = CreateDomainResponse

    request  = post "CreateDomain"
    response = xmlResponse

instance FromXML CreateDomainResponse where
    parseXML = withElement "CreateDomainResult" $ \x -> CreateDomainResponse
        <$> x .@? "DomainStatus"
