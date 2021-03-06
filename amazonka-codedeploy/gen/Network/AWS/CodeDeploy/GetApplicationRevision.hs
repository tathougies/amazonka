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

-- Module      : Network.AWS.CodeDeploy.GetApplicationRevision
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

-- | Gets information about an application revision.
--
-- <http://docs.aws.amazon.com/codedeploy/latest/APIReference/API_GetApplicationRevision.html>
module Network.AWS.CodeDeploy.GetApplicationRevision
    (
    -- * Request
      GetApplicationRevision
    -- ** Request constructor
    , getApplicationRevision
    -- ** Request lenses
    , garApplicationName
    , garRevision

    -- * Response
    , GetApplicationRevisionResponse
    -- ** Response constructor
    , getApplicationRevisionResponse
    -- ** Response lenses
    , garrApplicationName
    , garrRevision
    , garrRevisionInfo
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.CodeDeploy.Types
import qualified GHC.Exts

data GetApplicationRevision = GetApplicationRevision
    { _garApplicationName :: Text
    , _garRevision        :: RevisionLocation
    } deriving (Eq, Read, Show)

-- | 'GetApplicationRevision' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'garApplicationName' @::@ 'Text'
--
-- * 'garRevision' @::@ 'RevisionLocation'
--
getApplicationRevision :: Text -- ^ 'garApplicationName'
                       -> RevisionLocation -- ^ 'garRevision'
                       -> GetApplicationRevision
getApplicationRevision p1 p2 = GetApplicationRevision
    { _garApplicationName = p1
    , _garRevision        = p2
    }

-- | The name of the application that corresponds to the revision.
garApplicationName :: Lens' GetApplicationRevision Text
garApplicationName =
    lens _garApplicationName (\s a -> s { _garApplicationName = a })

-- | Information about the application revision to get, including the revision's
-- type and its location.
garRevision :: Lens' GetApplicationRevision RevisionLocation
garRevision = lens _garRevision (\s a -> s { _garRevision = a })

data GetApplicationRevisionResponse = GetApplicationRevisionResponse
    { _garrApplicationName :: Maybe Text
    , _garrRevision        :: Maybe RevisionLocation
    , _garrRevisionInfo    :: Maybe GenericRevisionInfo
    } deriving (Eq, Read, Show)

-- | 'GetApplicationRevisionResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'garrApplicationName' @::@ 'Maybe' 'Text'
--
-- * 'garrRevision' @::@ 'Maybe' 'RevisionLocation'
--
-- * 'garrRevisionInfo' @::@ 'Maybe' 'GenericRevisionInfo'
--
getApplicationRevisionResponse :: GetApplicationRevisionResponse
getApplicationRevisionResponse = GetApplicationRevisionResponse
    { _garrApplicationName = Nothing
    , _garrRevision        = Nothing
    , _garrRevisionInfo    = Nothing
    }

-- | The name of the application that corresponds to the revision.
garrApplicationName :: Lens' GetApplicationRevisionResponse (Maybe Text)
garrApplicationName =
    lens _garrApplicationName (\s a -> s { _garrApplicationName = a })

-- | Additional information about the revision, including the revision's type and
-- its location.
garrRevision :: Lens' GetApplicationRevisionResponse (Maybe RevisionLocation)
garrRevision = lens _garrRevision (\s a -> s { _garrRevision = a })

-- | General information about the revision.
garrRevisionInfo :: Lens' GetApplicationRevisionResponse (Maybe GenericRevisionInfo)
garrRevisionInfo = lens _garrRevisionInfo (\s a -> s { _garrRevisionInfo = a })

instance ToPath GetApplicationRevision where
    toPath = const "/"

instance ToQuery GetApplicationRevision where
    toQuery = const mempty

instance ToHeaders GetApplicationRevision

instance ToJSON GetApplicationRevision where
    toJSON GetApplicationRevision{..} = object
        [ "applicationName" .= _garApplicationName
        , "revision"        .= _garRevision
        ]

instance AWSRequest GetApplicationRevision where
    type Sv GetApplicationRevision = CodeDeploy
    type Rs GetApplicationRevision = GetApplicationRevisionResponse

    request  = post "GetApplicationRevision"
    response = jsonResponse

instance FromJSON GetApplicationRevisionResponse where
    parseJSON = withObject "GetApplicationRevisionResponse" $ \o -> GetApplicationRevisionResponse
        <$> o .:? "applicationName"
        <*> o .:? "revision"
        <*> o .:? "revisionInfo"
