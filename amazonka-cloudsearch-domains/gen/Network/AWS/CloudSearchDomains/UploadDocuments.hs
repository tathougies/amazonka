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

-- Module      : Network.AWS.CloudSearchDomains.UploadDocuments
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

-- | Posts a batch of documents to a search domain for indexing. A document batch
-- is a collection of add and delete operations that represent the documents you
-- want to add, update, or delete from your domain. Batches can be described in
-- either JSON or XML. Each item that you want Amazon CloudSearch to return as a
-- search result (such as a product) is represented as a document. Every
-- document has a unique ID and one or more fields that contain the data that
-- you want to search and return in results. Individual documents cannot contain
-- more than 1 MB of data. The entire batch cannot exceed 5 MB. To get the best
-- possible upload performance, group add and delete operations in batches that
-- are close the 5 MB limit. Submitting a large volume of single-document
-- batches can overload a domain's document service.
--
-- The endpoint for submitting 'UploadDocuments' requests is domain-specific. To
-- get the document endpoint for your domain, use the Amazon CloudSearch
-- configuration service 'DescribeDomains' action. A domain's endpoints are also
-- displayed on the domain dashboard in the Amazon CloudSearch console.
--
-- For more information about formatting your data for Amazon CloudSearch, see <http://docs.aws.amazon.com/cloudsearch/latest/developerguide/preparing-data.html Preparing Your Data> in the /Amazon CloudSearch Developer Guide/. For more information about
-- uploading data for indexing, see <http://docs.aws.amazon.com/cloudsearch/latest/developerguide/uploading-data.html Uploading Data> in the /Amazon CloudSearchDeveloper Guide/.
--
-- <http://docs.aws.amazon.com/cloudsearch/latest/developerguide/API_UploadDocuments.html>
module Network.AWS.CloudSearchDomains.UploadDocuments
    (
    -- * Request
      UploadDocuments
    -- ** Request constructor
    , uploadDocuments
    -- ** Request lenses
    , udContentType
    , udDocuments

    -- * Response
    , UploadDocumentsResponse
    -- ** Response constructor
    , uploadDocumentsResponse
    -- ** Response lenses
    , udrAdds
    , udrDeletes
    , udrStatus
    , udrWarnings
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.RestJSON
import Network.AWS.CloudSearchDomains.Types
import qualified GHC.Exts

data UploadDocuments = UploadDocuments
    { _udContentType :: ContentType
    , _udDocuments   :: Base64
    } deriving (Eq, Read, Show)

-- | 'UploadDocuments' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'udContentType' @::@ 'ContentType'
--
-- * 'udDocuments' @::@ 'Base64'
--
uploadDocuments :: Base64 -- ^ 'udDocuments'
                -> ContentType -- ^ 'udContentType'
                -> UploadDocuments
uploadDocuments p1 p2 = UploadDocuments
    { _udDocuments   = p1
    , _udContentType = p2
    }

-- | The format of the batch you are uploading. Amazon CloudSearch supports two
-- document batch formats:
--
-- application/json application/xml
udContentType :: Lens' UploadDocuments ContentType
udContentType = lens _udContentType (\s a -> s { _udContentType = a })

-- | A batch of documents formatted in JSON or HTML.
udDocuments :: Lens' UploadDocuments Base64
udDocuments = lens _udDocuments (\s a -> s { _udDocuments = a })

data UploadDocumentsResponse = UploadDocumentsResponse
    { _udrAdds     :: Maybe Integer
    , _udrDeletes  :: Maybe Integer
    , _udrStatus   :: Maybe Text
    , _udrWarnings :: List "warnings" DocumentServiceWarning
    } deriving (Eq, Read, Show)

-- | 'UploadDocumentsResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'udrAdds' @::@ 'Maybe' 'Integer'
--
-- * 'udrDeletes' @::@ 'Maybe' 'Integer'
--
-- * 'udrStatus' @::@ 'Maybe' 'Text'
--
-- * 'udrWarnings' @::@ ['DocumentServiceWarning']
--
uploadDocumentsResponse :: UploadDocumentsResponse
uploadDocumentsResponse = UploadDocumentsResponse
    { _udrStatus   = Nothing
    , _udrAdds     = Nothing
    , _udrDeletes  = Nothing
    , _udrWarnings = mempty
    }

-- | The number of documents that were added to the search domain.
udrAdds :: Lens' UploadDocumentsResponse (Maybe Integer)
udrAdds = lens _udrAdds (\s a -> s { _udrAdds = a })

-- | The number of documents that were deleted from the search domain.
udrDeletes :: Lens' UploadDocumentsResponse (Maybe Integer)
udrDeletes = lens _udrDeletes (\s a -> s { _udrDeletes = a })

-- | The status of an 'UploadDocumentsRequest'.
udrStatus :: Lens' UploadDocumentsResponse (Maybe Text)
udrStatus = lens _udrStatus (\s a -> s { _udrStatus = a })

-- | Any warnings returned by the document service about the documents being
-- uploaded.
udrWarnings :: Lens' UploadDocumentsResponse [DocumentServiceWarning]
udrWarnings = lens _udrWarnings (\s a -> s { _udrWarnings = a }) . _List

instance ToPath UploadDocuments where
    toPath = const "/2013-01-01/documents/batch"

instance ToQuery UploadDocuments where
    toQuery = const "format=sdk"

instance ToHeaders UploadDocuments where
    toHeaders UploadDocuments{..} = mconcat
        [ "Content-Type" =: _udContentType
        ]

instance ToJSON UploadDocuments where
    toJSON UploadDocuments{..} = object
        [ "documents" .= _udDocuments
        ]

instance AWSRequest UploadDocuments where
    type Sv UploadDocuments = CloudSearchDomains
    type Rs UploadDocuments = UploadDocumentsResponse

    request  = post
    response = jsonResponse

instance FromJSON UploadDocumentsResponse where
    parseJSON = withObject "UploadDocumentsResponse" $ \o -> UploadDocumentsResponse
        <$> o .:? "adds"
        <*> o .:? "deletes"
        <*> o .:? "status"
        <*> o .:? "warnings" .!= mempty
