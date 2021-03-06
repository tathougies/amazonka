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

-- Module      : Network.AWS.OpsWorks.CreateDeployment
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

-- | Runs deployment or stack commands. For more information, see <http://docs.aws.amazon.com/opsworks/latest/userguide/workingapps-deploying.html Deploying Apps>
-- and <http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-commands.html Run Stack Commands>.
--
-- Required Permissions: To use this action, an IAM user must have a Deploy or
-- Manage permissions level for the stack, or an attached policy that explicitly
-- grants permissions. For more information on user permissions, see <http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html ManagingUser Permissions>.
--
-- <http://docs.aws.amazon.com/opsworks/latest/APIReference/API_CreateDeployment.html>
module Network.AWS.OpsWorks.CreateDeployment
    (
    -- * Request
      CreateDeployment
    -- ** Request constructor
    , createDeployment
    -- ** Request lenses
    , cdAppId
    , cdCommand
    , cdComment
    , cdCustomJson
    , cdInstanceIds
    , cdStackId

    -- * Response
    , CreateDeploymentResponse
    -- ** Response constructor
    , createDeploymentResponse
    -- ** Response lenses
    , cdrDeploymentId
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.OpsWorks.Types
import qualified GHC.Exts

data CreateDeployment = CreateDeployment
    { _cdAppId       :: Maybe Text
    , _cdCommand     :: DeploymentCommand
    , _cdComment     :: Maybe Text
    , _cdCustomJson  :: Maybe Text
    , _cdInstanceIds :: List "InstanceIds" Text
    , _cdStackId     :: Text
    } deriving (Eq, Read, Show)

-- | 'CreateDeployment' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cdAppId' @::@ 'Maybe' 'Text'
--
-- * 'cdCommand' @::@ 'DeploymentCommand'
--
-- * 'cdComment' @::@ 'Maybe' 'Text'
--
-- * 'cdCustomJson' @::@ 'Maybe' 'Text'
--
-- * 'cdInstanceIds' @::@ ['Text']
--
-- * 'cdStackId' @::@ 'Text'
--
createDeployment :: Text -- ^ 'cdStackId'
                 -> DeploymentCommand -- ^ 'cdCommand'
                 -> CreateDeployment
createDeployment p1 p2 = CreateDeployment
    { _cdStackId     = p1
    , _cdCommand     = p2
    , _cdAppId       = Nothing
    , _cdInstanceIds = mempty
    , _cdComment     = Nothing
    , _cdCustomJson  = Nothing
    }

-- | The app ID. This parameter is required for app deployments, but not for other
-- deployment commands.
cdAppId :: Lens' CreateDeployment (Maybe Text)
cdAppId = lens _cdAppId (\s a -> s { _cdAppId = a })

-- | A 'DeploymentCommand' object that specifies the deployment command and any
-- associated arguments.
cdCommand :: Lens' CreateDeployment DeploymentCommand
cdCommand = lens _cdCommand (\s a -> s { _cdCommand = a })

-- | A user-defined comment.
cdComment :: Lens' CreateDeployment (Maybe Text)
cdComment = lens _cdComment (\s a -> s { _cdComment = a })

-- | A string that contains user-defined, custom JSON. It is used to override the
-- corresponding default stack configuration JSON values. The string should be
-- in the following format and must escape characters such as '"'.:
--
-- '"{\"key1\": \"value1\", \"key2\": \"value2\",...}"'
--
-- For more information on custom JSON, see <http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-json.html Use Custom JSON to Modify the StackConfiguration JSON>.
cdCustomJson :: Lens' CreateDeployment (Maybe Text)
cdCustomJson = lens _cdCustomJson (\s a -> s { _cdCustomJson = a })

-- | The instance IDs for the deployment targets.
cdInstanceIds :: Lens' CreateDeployment [Text]
cdInstanceIds = lens _cdInstanceIds (\s a -> s { _cdInstanceIds = a }) . _List

-- | The stack ID.
cdStackId :: Lens' CreateDeployment Text
cdStackId = lens _cdStackId (\s a -> s { _cdStackId = a })

newtype CreateDeploymentResponse = CreateDeploymentResponse
    { _cdrDeploymentId :: Maybe Text
    } deriving (Eq, Ord, Read, Show, Monoid)

-- | 'CreateDeploymentResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cdrDeploymentId' @::@ 'Maybe' 'Text'
--
createDeploymentResponse :: CreateDeploymentResponse
createDeploymentResponse = CreateDeploymentResponse
    { _cdrDeploymentId = Nothing
    }

-- | The deployment ID, which can be used with other requests to identify the
-- deployment.
cdrDeploymentId :: Lens' CreateDeploymentResponse (Maybe Text)
cdrDeploymentId = lens _cdrDeploymentId (\s a -> s { _cdrDeploymentId = a })

instance ToPath CreateDeployment where
    toPath = const "/"

instance ToQuery CreateDeployment where
    toQuery = const mempty

instance ToHeaders CreateDeployment

instance ToJSON CreateDeployment where
    toJSON CreateDeployment{..} = object
        [ "StackId"     .= _cdStackId
        , "AppId"       .= _cdAppId
        , "InstanceIds" .= _cdInstanceIds
        , "Command"     .= _cdCommand
        , "Comment"     .= _cdComment
        , "CustomJson"  .= _cdCustomJson
        ]

instance AWSRequest CreateDeployment where
    type Sv CreateDeployment = OpsWorks
    type Rs CreateDeployment = CreateDeploymentResponse

    request  = post "CreateDeployment"
    response = jsonResponse

instance FromJSON CreateDeploymentResponse where
    parseJSON = withObject "CreateDeploymentResponse" $ \o -> CreateDeploymentResponse
        <$> o .:? "DeploymentId"
