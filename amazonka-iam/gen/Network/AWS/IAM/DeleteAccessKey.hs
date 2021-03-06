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

-- Module      : Network.AWS.IAM.DeleteAccessKey
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

-- | Deletes the access key associated with the specified user.
--
-- If you do not specify a user name, IAM determines the user name implicitly
-- based on the AWS access key ID signing the request. Because this action works
-- for access keys under the AWS account, you can use this action to manage root
-- credentials even if the AWS account has no associated users.
--
-- <http://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteAccessKey.html>
module Network.AWS.IAM.DeleteAccessKey
    (
    -- * Request
      DeleteAccessKey
    -- ** Request constructor
    , deleteAccessKey
    -- ** Request lenses
    , dakAccessKeyId
    , dakUserName

    -- * Response
    , DeleteAccessKeyResponse
    -- ** Response constructor
    , deleteAccessKeyResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.IAM.Types
import qualified GHC.Exts

data DeleteAccessKey = DeleteAccessKey
    { _dakAccessKeyId :: Text
    , _dakUserName    :: Maybe Text
    } deriving (Eq, Ord, Read, Show)

-- | 'DeleteAccessKey' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dakAccessKeyId' @::@ 'Text'
--
-- * 'dakUserName' @::@ 'Maybe' 'Text'
--
deleteAccessKey :: Text -- ^ 'dakAccessKeyId'
                -> DeleteAccessKey
deleteAccessKey p1 = DeleteAccessKey
    { _dakAccessKeyId = p1
    , _dakUserName    = Nothing
    }

-- | The access key ID for the access key ID and secret access key you want to
-- delete.
dakAccessKeyId :: Lens' DeleteAccessKey Text
dakAccessKeyId = lens _dakAccessKeyId (\s a -> s { _dakAccessKeyId = a })

-- | The name of the user whose key you want to delete.
dakUserName :: Lens' DeleteAccessKey (Maybe Text)
dakUserName = lens _dakUserName (\s a -> s { _dakUserName = a })

data DeleteAccessKeyResponse = DeleteAccessKeyResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'DeleteAccessKeyResponse' constructor.
deleteAccessKeyResponse :: DeleteAccessKeyResponse
deleteAccessKeyResponse = DeleteAccessKeyResponse

instance ToPath DeleteAccessKey where
    toPath = const "/"

instance ToQuery DeleteAccessKey where
    toQuery DeleteAccessKey{..} = mconcat
        [ "AccessKeyId" =? _dakAccessKeyId
        , "UserName"    =? _dakUserName
        ]

instance ToHeaders DeleteAccessKey

instance AWSRequest DeleteAccessKey where
    type Sv DeleteAccessKey = IAM
    type Rs DeleteAccessKey = DeleteAccessKeyResponse

    request  = post "DeleteAccessKey"
    response = nullResponse DeleteAccessKeyResponse
