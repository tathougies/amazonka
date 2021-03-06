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

-- Module      : Network.AWS.RDS.CreateDBSecurityGroup
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

-- | Creates a new DB security group. DB security groups control access to a DB
-- instance.
--
-- <http://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBSecurityGroup.html>
module Network.AWS.RDS.CreateDBSecurityGroup
    (
    -- * Request
      CreateDBSecurityGroup
    -- ** Request constructor
    , createDBSecurityGroup
    -- ** Request lenses
    , cdbsgDBSecurityGroupDescription
    , cdbsgDBSecurityGroupName
    , cdbsgTags

    -- * Response
    , CreateDBSecurityGroupResponse
    -- ** Response constructor
    , createDBSecurityGroupResponse
    -- ** Response lenses
    , cdbsgrDBSecurityGroup
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.RDS.Types
import qualified GHC.Exts

data CreateDBSecurityGroup = CreateDBSecurityGroup
    { _cdbsgDBSecurityGroupDescription :: Text
    , _cdbsgDBSecurityGroupName        :: Text
    , _cdbsgTags                       :: List "member" Tag
    } deriving (Eq, Read, Show)

-- | 'CreateDBSecurityGroup' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cdbsgDBSecurityGroupDescription' @::@ 'Text'
--
-- * 'cdbsgDBSecurityGroupName' @::@ 'Text'
--
-- * 'cdbsgTags' @::@ ['Tag']
--
createDBSecurityGroup :: Text -- ^ 'cdbsgDBSecurityGroupName'
                      -> Text -- ^ 'cdbsgDBSecurityGroupDescription'
                      -> CreateDBSecurityGroup
createDBSecurityGroup p1 p2 = CreateDBSecurityGroup
    { _cdbsgDBSecurityGroupName        = p1
    , _cdbsgDBSecurityGroupDescription = p2
    , _cdbsgTags                       = mempty
    }

-- | The description for the DB security group.
cdbsgDBSecurityGroupDescription :: Lens' CreateDBSecurityGroup Text
cdbsgDBSecurityGroupDescription =
    lens _cdbsgDBSecurityGroupDescription
        (\s a -> s { _cdbsgDBSecurityGroupDescription = a })

-- | The name for the DB security group. This value is stored as a lowercase
-- string.
--
-- Constraints:
--
-- Must be 1 to 255 alphanumeric characters First character must be a letter Cannot end with a hyphen or contain two consecutive hyphens
-- Must not be "Default" May not contain spaces  Example: 'mysecuritygroup'
cdbsgDBSecurityGroupName :: Lens' CreateDBSecurityGroup Text
cdbsgDBSecurityGroupName =
    lens _cdbsgDBSecurityGroupName
        (\s a -> s { _cdbsgDBSecurityGroupName = a })

cdbsgTags :: Lens' CreateDBSecurityGroup [Tag]
cdbsgTags = lens _cdbsgTags (\s a -> s { _cdbsgTags = a }) . _List

newtype CreateDBSecurityGroupResponse = CreateDBSecurityGroupResponse
    { _cdbsgrDBSecurityGroup :: Maybe DBSecurityGroup
    } deriving (Eq, Read, Show)

-- | 'CreateDBSecurityGroupResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cdbsgrDBSecurityGroup' @::@ 'Maybe' 'DBSecurityGroup'
--
createDBSecurityGroupResponse :: CreateDBSecurityGroupResponse
createDBSecurityGroupResponse = CreateDBSecurityGroupResponse
    { _cdbsgrDBSecurityGroup = Nothing
    }

cdbsgrDBSecurityGroup :: Lens' CreateDBSecurityGroupResponse (Maybe DBSecurityGroup)
cdbsgrDBSecurityGroup =
    lens _cdbsgrDBSecurityGroup (\s a -> s { _cdbsgrDBSecurityGroup = a })

instance ToPath CreateDBSecurityGroup where
    toPath = const "/"

instance ToQuery CreateDBSecurityGroup where
    toQuery CreateDBSecurityGroup{..} = mconcat
        [ "DBSecurityGroupDescription" =? _cdbsgDBSecurityGroupDescription
        , "DBSecurityGroupName"        =? _cdbsgDBSecurityGroupName
        , "Tags"                       =? _cdbsgTags
        ]

instance ToHeaders CreateDBSecurityGroup

instance AWSRequest CreateDBSecurityGroup where
    type Sv CreateDBSecurityGroup = RDS
    type Rs CreateDBSecurityGroup = CreateDBSecurityGroupResponse

    request  = post "CreateDBSecurityGroup"
    response = xmlResponse

instance FromXML CreateDBSecurityGroupResponse where
    parseXML = withElement "CreateDBSecurityGroupResult" $ \x -> CreateDBSecurityGroupResponse
        <$> x .@? "DBSecurityGroup"
