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

-- Module      : Network.AWS.OpsWorks.DescribeMyUserProfile
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

-- | Describes a user's SSH information.
--
-- Required Permissions: To use this action, an IAM user must have
-- self-management enabled or an attached policy that explicitly grants
-- permissions. For more information on user permissions, see <http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html Managing UserPermissions>.
--
-- <http://docs.aws.amazon.com/opsworks/latest/APIReference/API_DescribeMyUserProfile.html>
module Network.AWS.OpsWorks.DescribeMyUserProfile
    (
    -- * Request
      DescribeMyUserProfile
    -- ** Request constructor
    , describeMyUserProfile

    -- * Response
    , DescribeMyUserProfileResponse
    -- ** Response constructor
    , describeMyUserProfileResponse
    -- ** Response lenses
    , dmuprUserProfile
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.OpsWorks.Types
import qualified GHC.Exts

data DescribeMyUserProfile = DescribeMyUserProfile
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'DescribeMyUserProfile' constructor.
describeMyUserProfile :: DescribeMyUserProfile
describeMyUserProfile = DescribeMyUserProfile

newtype DescribeMyUserProfileResponse = DescribeMyUserProfileResponse
    { _dmuprUserProfile :: Maybe SelfUserProfile
    } deriving (Eq, Read, Show)

-- | 'DescribeMyUserProfileResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dmuprUserProfile' @::@ 'Maybe' 'SelfUserProfile'
--
describeMyUserProfileResponse :: DescribeMyUserProfileResponse
describeMyUserProfileResponse = DescribeMyUserProfileResponse
    { _dmuprUserProfile = Nothing
    }

-- | A 'UserProfile' object that describes the user's SSH information.
dmuprUserProfile :: Lens' DescribeMyUserProfileResponse (Maybe SelfUserProfile)
dmuprUserProfile = lens _dmuprUserProfile (\s a -> s { _dmuprUserProfile = a })

instance ToPath DescribeMyUserProfile where
    toPath = const "/"

instance ToQuery DescribeMyUserProfile where
    toQuery = const mempty

instance ToHeaders DescribeMyUserProfile

instance ToJSON DescribeMyUserProfile where
    toJSON = const (toJSON Empty)

instance AWSRequest DescribeMyUserProfile where
    type Sv DescribeMyUserProfile = OpsWorks
    type Rs DescribeMyUserProfile = DescribeMyUserProfileResponse

    request  = post "DescribeMyUserProfile"
    response = jsonResponse

instance FromJSON DescribeMyUserProfileResponse where
    parseJSON = withObject "DescribeMyUserProfileResponse" $ \o -> DescribeMyUserProfileResponse
        <$> o .:? "UserProfile"
