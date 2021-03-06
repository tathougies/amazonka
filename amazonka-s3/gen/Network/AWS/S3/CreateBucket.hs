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

-- Module      : Network.AWS.S3.CreateBucket
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

-- | Creates a new bucket.
--
-- <http://docs.aws.amazon.com/AmazonS3/latest/API/CreateBucket.html>
module Network.AWS.S3.CreateBucket
    (
    -- * Request
      CreateBucket
    -- ** Request constructor
    , createBucket
    -- ** Request lenses
    , cbACL
    , cbBucket
    , cbCreateBucketConfiguration
    , cbGrantFullControl
    , cbGrantRead
    , cbGrantReadACP
    , cbGrantWrite
    , cbGrantWriteACP

    -- * Response
    , CreateBucketResponse
    -- ** Response constructor
    , createBucketResponse
    -- ** Response lenses
    , cbrLocation
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.S3
import Network.AWS.S3.Types
import qualified GHC.Exts

data CreateBucket = CreateBucket
    { _cbACL                       :: Maybe BucketCannedACL
    , _cbBucket                    :: Text
    , _cbCreateBucketConfiguration :: Maybe CreateBucketConfiguration
    , _cbGrantFullControl          :: Maybe Text
    , _cbGrantRead                 :: Maybe Text
    , _cbGrantReadACP              :: Maybe Text
    , _cbGrantWrite                :: Maybe Text
    , _cbGrantWriteACP             :: Maybe Text
    } deriving (Eq, Read, Show)

-- | 'CreateBucket' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cbACL' @::@ 'Maybe' 'BucketCannedACL'
--
-- * 'cbBucket' @::@ 'Text'
--
-- * 'cbCreateBucketConfiguration' @::@ 'Maybe' 'CreateBucketConfiguration'
--
-- * 'cbGrantFullControl' @::@ 'Maybe' 'Text'
--
-- * 'cbGrantRead' @::@ 'Maybe' 'Text'
--
-- * 'cbGrantReadACP' @::@ 'Maybe' 'Text'
--
-- * 'cbGrantWrite' @::@ 'Maybe' 'Text'
--
-- * 'cbGrantWriteACP' @::@ 'Maybe' 'Text'
--
createBucket :: Text -- ^ 'cbBucket'
             -> CreateBucket
createBucket p1 = CreateBucket
    { _cbBucket                    = p1
    , _cbACL                       = Nothing
    , _cbCreateBucketConfiguration = Nothing
    , _cbGrantFullControl          = Nothing
    , _cbGrantRead                 = Nothing
    , _cbGrantReadACP              = Nothing
    , _cbGrantWrite                = Nothing
    , _cbGrantWriteACP             = Nothing
    }

-- | The canned ACL to apply to the bucket.
cbACL :: Lens' CreateBucket (Maybe BucketCannedACL)
cbACL = lens _cbACL (\s a -> s { _cbACL = a })

cbBucket :: Lens' CreateBucket Text
cbBucket = lens _cbBucket (\s a -> s { _cbBucket = a })

cbCreateBucketConfiguration :: Lens' CreateBucket (Maybe CreateBucketConfiguration)
cbCreateBucketConfiguration =
    lens _cbCreateBucketConfiguration
        (\s a -> s { _cbCreateBucketConfiguration = a })

-- | Allows grantee the read, write, read ACP, and write ACP permissions on the
-- bucket.
cbGrantFullControl :: Lens' CreateBucket (Maybe Text)
cbGrantFullControl =
    lens _cbGrantFullControl (\s a -> s { _cbGrantFullControl = a })

-- | Allows grantee to list the objects in the bucket.
cbGrantRead :: Lens' CreateBucket (Maybe Text)
cbGrantRead = lens _cbGrantRead (\s a -> s { _cbGrantRead = a })

-- | Allows grantee to read the bucket ACL.
cbGrantReadACP :: Lens' CreateBucket (Maybe Text)
cbGrantReadACP = lens _cbGrantReadACP (\s a -> s { _cbGrantReadACP = a })

-- | Allows grantee to create, overwrite, and delete any object in the bucket.
cbGrantWrite :: Lens' CreateBucket (Maybe Text)
cbGrantWrite = lens _cbGrantWrite (\s a -> s { _cbGrantWrite = a })

-- | Allows grantee to write the ACL for the applicable bucket.
cbGrantWriteACP :: Lens' CreateBucket (Maybe Text)
cbGrantWriteACP = lens _cbGrantWriteACP (\s a -> s { _cbGrantWriteACP = a })

newtype CreateBucketResponse = CreateBucketResponse
    { _cbrLocation :: Maybe Text
    } deriving (Eq, Ord, Read, Show, Monoid)

-- | 'CreateBucketResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cbrLocation' @::@ 'Maybe' 'Text'
--
createBucketResponse :: CreateBucketResponse
createBucketResponse = CreateBucketResponse
    { _cbrLocation = Nothing
    }

cbrLocation :: Lens' CreateBucketResponse (Maybe Text)
cbrLocation = lens _cbrLocation (\s a -> s { _cbrLocation = a })

instance ToPath CreateBucket where
    toPath CreateBucket{..} = mconcat
        [ "/"
        , toText _cbBucket
        ]

instance ToQuery CreateBucket where
    toQuery = const mempty

instance ToHeaders CreateBucket where
    toHeaders CreateBucket{..} = mconcat
        [ "x-amz-acl"                =: _cbACL
        , "x-amz-grant-full-control" =: _cbGrantFullControl
        , "x-amz-grant-read"         =: _cbGrantRead
        , "x-amz-grant-read-acp"     =: _cbGrantReadACP
        , "x-amz-grant-write"        =: _cbGrantWrite
        , "x-amz-grant-write-acp"    =: _cbGrantWriteACP
        ]

instance ToXMLRoot CreateBucket where
    toXMLRoot CreateBucket{..} = namespaced ns "CreateBucket"
        [ "CreateBucketConfiguration" =@ _cbCreateBucketConfiguration
        ]

instance ToXML CreateBucket

instance AWSRequest CreateBucket where
    type Sv CreateBucket = S3
    type Rs CreateBucket = CreateBucketResponse

    request  = put
    response = headerResponse $ \h -> CreateBucketResponse
        <$> h ~:? "Location"
