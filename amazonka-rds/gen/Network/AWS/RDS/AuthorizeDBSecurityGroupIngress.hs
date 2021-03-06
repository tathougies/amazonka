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

-- Module      : Network.AWS.RDS.AuthorizeDBSecurityGroupIngress
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

-- | Enables ingress to a DBSecurityGroup using one of two forms of
-- authorization. First, EC2 or VPC security groups can be added to the
-- DBSecurityGroup if the application using the database is running on EC2 or
-- VPC instances. Second, IP ranges are available if the application accessing
-- your database is running on the Internet. Required parameters for this API
-- are one of CIDR range, EC2SecurityGroupId for VPC, or
-- (EC2SecurityGroupOwnerId and either EC2SecurityGroupName or
-- EC2SecurityGroupId for non-VPC).
--
-- You cannot authorize ingress from an EC2 security group in one Region to an
-- Amazon RDS DB instance in another. You cannot authorize ingress from a VPC
-- security group in one VPC to an Amazon RDS DB instance in another.  For an
-- overview of CIDR ranges, go to the <http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing Wikipedia Tutorial>.
--
-- <http://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_AuthorizeDBSecurityGroupIngress.html>
module Network.AWS.RDS.AuthorizeDBSecurityGroupIngress
    (
    -- * Request
      AuthorizeDBSecurityGroupIngress
    -- ** Request constructor
    , authorizeDBSecurityGroupIngress
    -- ** Request lenses
    , adbsgiCIDRIP
    , adbsgiDBSecurityGroupName
    , adbsgiEC2SecurityGroupId
    , adbsgiEC2SecurityGroupName
    , adbsgiEC2SecurityGroupOwnerId

    -- * Response
    , AuthorizeDBSecurityGroupIngressResponse
    -- ** Response constructor
    , authorizeDBSecurityGroupIngressResponse
    -- ** Response lenses
    , adbsgirDBSecurityGroup
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.RDS.Types
import qualified GHC.Exts

data AuthorizeDBSecurityGroupIngress = AuthorizeDBSecurityGroupIngress
    { _adbsgiCIDRIP                  :: Maybe Text
    , _adbsgiDBSecurityGroupName     :: Text
    , _adbsgiEC2SecurityGroupId      :: Maybe Text
    , _adbsgiEC2SecurityGroupName    :: Maybe Text
    , _adbsgiEC2SecurityGroupOwnerId :: Maybe Text
    } deriving (Eq, Ord, Read, Show)

-- | 'AuthorizeDBSecurityGroupIngress' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'adbsgiCIDRIP' @::@ 'Maybe' 'Text'
--
-- * 'adbsgiDBSecurityGroupName' @::@ 'Text'
--
-- * 'adbsgiEC2SecurityGroupId' @::@ 'Maybe' 'Text'
--
-- * 'adbsgiEC2SecurityGroupName' @::@ 'Maybe' 'Text'
--
-- * 'adbsgiEC2SecurityGroupOwnerId' @::@ 'Maybe' 'Text'
--
authorizeDBSecurityGroupIngress :: Text -- ^ 'adbsgiDBSecurityGroupName'
                                -> AuthorizeDBSecurityGroupIngress
authorizeDBSecurityGroupIngress p1 = AuthorizeDBSecurityGroupIngress
    { _adbsgiDBSecurityGroupName     = p1
    , _adbsgiCIDRIP                  = Nothing
    , _adbsgiEC2SecurityGroupName    = Nothing
    , _adbsgiEC2SecurityGroupId      = Nothing
    , _adbsgiEC2SecurityGroupOwnerId = Nothing
    }

-- | The IP range to authorize.
adbsgiCIDRIP :: Lens' AuthorizeDBSecurityGroupIngress (Maybe Text)
adbsgiCIDRIP = lens _adbsgiCIDRIP (\s a -> s { _adbsgiCIDRIP = a })

-- | The name of the DB security group to add authorization to.
adbsgiDBSecurityGroupName :: Lens' AuthorizeDBSecurityGroupIngress Text
adbsgiDBSecurityGroupName =
    lens _adbsgiDBSecurityGroupName
        (\s a -> s { _adbsgiDBSecurityGroupName = a })

-- | Id of the EC2 security group to authorize. For VPC DB security groups, 'EC2SecurityGroupId' must be provided. Otherwise, EC2SecurityGroupOwnerId and either 'EC2SecurityGroupName' or 'EC2SecurityGroupId' must be provided.
adbsgiEC2SecurityGroupId :: Lens' AuthorizeDBSecurityGroupIngress (Maybe Text)
adbsgiEC2SecurityGroupId =
    lens _adbsgiEC2SecurityGroupId
        (\s a -> s { _adbsgiEC2SecurityGroupId = a })

-- | Name of the EC2 security group to authorize. For VPC DB security groups, 'EC2SecurityGroupId' must be provided. Otherwise, EC2SecurityGroupOwnerId and either 'EC2SecurityGroupName' or 'EC2SecurityGroupId' must be provided.
adbsgiEC2SecurityGroupName :: Lens' AuthorizeDBSecurityGroupIngress (Maybe Text)
adbsgiEC2SecurityGroupName =
    lens _adbsgiEC2SecurityGroupName
        (\s a -> s { _adbsgiEC2SecurityGroupName = a })

-- | AWS Account Number of the owner of the EC2 security group specified in the
-- EC2SecurityGroupName parameter. The AWS Access Key ID is not an acceptable
-- value. For VPC DB security groups, 'EC2SecurityGroupId' must be provided.
-- Otherwise, EC2SecurityGroupOwnerId and either 'EC2SecurityGroupName' or 'EC2SecurityGroupId' must be provided.
adbsgiEC2SecurityGroupOwnerId :: Lens' AuthorizeDBSecurityGroupIngress (Maybe Text)
adbsgiEC2SecurityGroupOwnerId =
    lens _adbsgiEC2SecurityGroupOwnerId
        (\s a -> s { _adbsgiEC2SecurityGroupOwnerId = a })

newtype AuthorizeDBSecurityGroupIngressResponse = AuthorizeDBSecurityGroupIngressResponse
    { _adbsgirDBSecurityGroup :: Maybe DBSecurityGroup
    } deriving (Eq, Read, Show)

-- | 'AuthorizeDBSecurityGroupIngressResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'adbsgirDBSecurityGroup' @::@ 'Maybe' 'DBSecurityGroup'
--
authorizeDBSecurityGroupIngressResponse :: AuthorizeDBSecurityGroupIngressResponse
authorizeDBSecurityGroupIngressResponse = AuthorizeDBSecurityGroupIngressResponse
    { _adbsgirDBSecurityGroup = Nothing
    }

adbsgirDBSecurityGroup :: Lens' AuthorizeDBSecurityGroupIngressResponse (Maybe DBSecurityGroup)
adbsgirDBSecurityGroup =
    lens _adbsgirDBSecurityGroup (\s a -> s { _adbsgirDBSecurityGroup = a })

instance ToPath AuthorizeDBSecurityGroupIngress where
    toPath = const "/"

instance ToQuery AuthorizeDBSecurityGroupIngress where
    toQuery AuthorizeDBSecurityGroupIngress{..} = mconcat
        [ "CIDRIP"                  =? _adbsgiCIDRIP
        , "DBSecurityGroupName"     =? _adbsgiDBSecurityGroupName
        , "EC2SecurityGroupId"      =? _adbsgiEC2SecurityGroupId
        , "EC2SecurityGroupName"    =? _adbsgiEC2SecurityGroupName
        , "EC2SecurityGroupOwnerId" =? _adbsgiEC2SecurityGroupOwnerId
        ]

instance ToHeaders AuthorizeDBSecurityGroupIngress

instance AWSRequest AuthorizeDBSecurityGroupIngress where
    type Sv AuthorizeDBSecurityGroupIngress = RDS
    type Rs AuthorizeDBSecurityGroupIngress = AuthorizeDBSecurityGroupIngressResponse

    request  = post "AuthorizeDBSecurityGroupIngress"
    response = xmlResponse

instance FromXML AuthorizeDBSecurityGroupIngressResponse where
    parseXML = withElement "AuthorizeDBSecurityGroupIngressResult" $ \x -> AuthorizeDBSecurityGroupIngressResponse
        <$> x .@? "DBSecurityGroup"
