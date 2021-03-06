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

-- Module      : Network.AWS.STS.AssumeRole
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

-- | Returns a set of temporary security credentials (consisting of an access key
-- ID, a secret access key, and a security token) that you can use to access AWS
-- resources that you might not normally have access to. Typically, you use 'AssumeRole' for cross-account access or federation.
--
-- Important: You cannot call 'AssumeRole' by using AWS account credentials;
-- access will be denied. You must use IAM user credentials or temporary
-- security credentials to call 'AssumeRole'.
--
-- For cross-account access, imagine that you own multiple accounts and need to
-- access resources in each account. You could create long-term credentials in
-- each account to access those resources. However, managing all those
-- credentials and remembering which one can access which account can be time
-- consuming. Instead, you can create one set of long-term credentials in one
-- account and then use temporary security credentials to access all the other
-- accounts by assuming roles in those accounts. For more information about
-- roles, see <http://docs.aws.amazon.com/IAM/latest/UserGuide/WorkingWithRoles.html Roles> in /Using IAM/.
--
-- For federation, you can, for example, grant single sign-on access to the AWS
-- Management Console. If you already have an identity and authentication system
-- in your corporate network, you don't have to recreate user identities in AWS
-- in order to grant those user identities access to AWS. Instead, after a user
-- has been authenticated, you call 'AssumeRole' (and specify the role with the
-- appropriate permissions) to get temporary security credentials for that user.
-- With those temporary security credentials, you construct a sign-in URL that
-- users can use to access the console. For more information, see <http://docs.aws.amazon.com/STS/latest/UsingSTS/STSUseCases.html Scenarios forGranting Temporary Access> in /Using Temporary Security Credentials/.
--
-- The temporary security credentials are valid for the duration that you
-- specified when calling 'AssumeRole', which can be from 900 seconds (15 minutes)
-- to 3600 seconds (1 hour). The default is 1 hour.
--
-- Optionally, you can pass an IAM access policy to this operation. If you
-- choose not to pass a policy, the temporary security credentials that are
-- returned by the operation have the permissions that are defined in the access
-- policy of the role that is being assumed. If you pass a policy to this
-- operation, the temporary security credentials that are returned by the
-- operation have the permissions that are allowed by both the access policy of
-- the role that is being assumed, /and/ the policy that you pass. This gives you
-- a way to further restrict the permissions for the resulting temporary
-- security credentials. You cannot use the passed policy to grant permissions
-- that are in excess of those allowed by the access policy of the role that is
-- being assumed. For more information, see <http://docs.aws.amazon.com/STS/latest/UsingSTS/permissions-assume-role.html Permissions for AssumeRole> in /UsingTemporary Security Credentials/.
--
-- To assume a role, your AWS account must be trusted by the role. The trust
-- relationship is defined in the role's trust policy when the role is created.
-- You must also have a policy that allows you to call 'sts:AssumeRole'.
--
-- Using MFA with AssumeRole
--
-- You can optionally include multi-factor authentication (MFA) information
-- when you call 'AssumeRole'. This is useful for cross-account scenarios in which
-- you want to make sure that the user who is assuming the role has been
-- authenticated using an AWS MFA device. In that scenario, the trust policy of
-- the role being assumed includes a condition that tests for MFA
-- authentication; if the caller does not include valid MFA information, the
-- request to assume the role is denied. The condition in a trust policy that
-- tests for MFA authentication might look like the following example.
--
-- '"Condition": {"Null": {"aws:MultiFactorAuthAge": false}}'
--
-- For more information, see <http://docs.aws.amazon.com/IAM/latest/UserGuide/MFAProtectedAPI.html Configuring MFA-Protected API Access> in the /UsingIAM/ guide.
--
-- To use MFA with 'AssumeRole', you pass values for the 'SerialNumber' and 'TokenCode' parameters. The 'SerialNumber' value identifies the user's hardware or virtual
-- MFA device. The 'TokenCode' is the time-based one-time password (TOTP) that the
-- MFA devices produces.
--
--
--
-- <http://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html>
module Network.AWS.STS.AssumeRole
    (
    -- * Request
      AssumeRole
    -- ** Request constructor
    , assumeRole
    -- ** Request lenses
    , arDurationSeconds
    , arExternalId
    , arPolicy
    , arRoleArn
    , arRoleSessionName
    , arSerialNumber
    , arTokenCode

    -- * Response
    , AssumeRoleResponse
    -- ** Response constructor
    , assumeRoleResponse
    -- ** Response lenses
    , arrAssumedRoleUser
    , arrCredentials
    , arrPackedPolicySize
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.STS.Types
import qualified GHC.Exts

data AssumeRole = AssumeRole
    { _arDurationSeconds :: Maybe Nat
    , _arExternalId      :: Maybe Text
    , _arPolicy          :: Maybe Text
    , _arRoleArn         :: Text
    , _arRoleSessionName :: Text
    , _arSerialNumber    :: Maybe Text
    , _arTokenCode       :: Maybe Text
    } deriving (Eq, Ord, Read, Show)

-- | 'AssumeRole' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'arDurationSeconds' @::@ 'Maybe' 'Natural'
--
-- * 'arExternalId' @::@ 'Maybe' 'Text'
--
-- * 'arPolicy' @::@ 'Maybe' 'Text'
--
-- * 'arRoleArn' @::@ 'Text'
--
-- * 'arRoleSessionName' @::@ 'Text'
--
-- * 'arSerialNumber' @::@ 'Maybe' 'Text'
--
-- * 'arTokenCode' @::@ 'Maybe' 'Text'
--
assumeRole :: Text -- ^ 'arRoleArn'
           -> Text -- ^ 'arRoleSessionName'
           -> AssumeRole
assumeRole p1 p2 = AssumeRole
    { _arRoleArn         = p1
    , _arRoleSessionName = p2
    , _arPolicy          = Nothing
    , _arDurationSeconds = Nothing
    , _arExternalId      = Nothing
    , _arSerialNumber    = Nothing
    , _arTokenCode       = Nothing
    }

-- | The duration, in seconds, of the role session. The value can range from 900
-- seconds (15 minutes) to 3600 seconds (1 hour). By default, the value is set
-- to 3600 seconds.
arDurationSeconds :: Lens' AssumeRole (Maybe Natural)
arDurationSeconds =
    lens _arDurationSeconds (\s a -> s { _arDurationSeconds = a })
        . mapping _Nat

-- | A unique identifier that is used by third parties to assume a role in their
-- customers' accounts. For each role that the third party can assume, they
-- should instruct their customers to create a role with the external ID that
-- the third party generated. Each time the third party assumes the role, they
-- must pass the customer's external ID. The external ID is useful in order to
-- help third parties bind a role to the customer who created it. For more
-- information about the external ID, see About the External ID in /UsingTemporary Security Credentials/.
arExternalId :: Lens' AssumeRole (Maybe Text)
arExternalId = lens _arExternalId (\s a -> s { _arExternalId = a })

-- | An IAM policy in JSON format.
--
-- The policy parameter is optional. If you pass a policy, the temporary
-- security credentials that are returned by the operation have the permissions
-- that are allowed by both the access policy of the role that is being assumed, /and/ the policy that you pass. This gives you a way to further restrict the
-- permissions for the resulting temporary security credentials. You cannot use
-- the passed policy to grant permissions that are in excess of those allowed by
-- the access policy of the role that is being assumed. For more information,
-- see <http://docs.aws.amazon.com/STS/latest/UsingSTS/permissions-assume-role.html Permissions for AssumeRole> in /Using Temporary Security Credentials/.
arPolicy :: Lens' AssumeRole (Maybe Text)
arPolicy = lens _arPolicy (\s a -> s { _arPolicy = a })

-- | The Amazon Resource Name (ARN) of the role that the caller is assuming.
arRoleArn :: Lens' AssumeRole Text
arRoleArn = lens _arRoleArn (\s a -> s { _arRoleArn = a })

-- | An identifier for the assumed role session. The session name is included as
-- part of the 'AssumedRoleUser'.
arRoleSessionName :: Lens' AssumeRole Text
arRoleSessionName =
    lens _arRoleSessionName (\s a -> s { _arRoleSessionName = a })

-- | The identification number of the MFA device that is associated with the user
-- who is making the 'AssumeRole' call. Specify this value if the trust policy of
-- the role being assumed includes a condition that requires MFA authentication.
-- The value is either the serial number for a hardware device (such as 'GAHT12345678') or an Amazon Resource Name (ARN) for a virtual device (such as 'arn:aws:iam::123456789012:mfa/user').
arSerialNumber :: Lens' AssumeRole (Maybe Text)
arSerialNumber = lens _arSerialNumber (\s a -> s { _arSerialNumber = a })

-- | The value provided by the MFA device, if the trust policy of the role being
-- assumed requires MFA (that is, if the policy includes a condition that tests
-- for MFA). If the role being assumed requires MFA and if the 'TokenCode' value
-- is missing or expired, the 'AssumeRole' call returns an "access denied" error.
arTokenCode :: Lens' AssumeRole (Maybe Text)
arTokenCode = lens _arTokenCode (\s a -> s { _arTokenCode = a })

data AssumeRoleResponse = AssumeRoleResponse
    { _arrAssumedRoleUser  :: Maybe AssumedRoleUser
    , _arrCredentials      :: Maybe Credentials
    , _arrPackedPolicySize :: Maybe Nat
    } deriving (Eq, Read, Show)

-- | 'AssumeRoleResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'arrAssumedRoleUser' @::@ 'Maybe' 'AssumedRoleUser'
--
-- * 'arrCredentials' @::@ 'Maybe' 'Credentials'
--
-- * 'arrPackedPolicySize' @::@ 'Maybe' 'Natural'
--
assumeRoleResponse :: AssumeRoleResponse
assumeRoleResponse = AssumeRoleResponse
    { _arrCredentials      = Nothing
    , _arrAssumedRoleUser  = Nothing
    , _arrPackedPolicySize = Nothing
    }

-- | The Amazon Resource Name (ARN) and the assumed role ID, which are identifiers
-- that you can use to refer to the resulting temporary security credentials.
-- For example, you can reference these credentials as a principal in a
-- resource-based policy by using the ARN or assumed role ID. The ARN and ID
-- include the 'RoleSessionName' that you specified when you called 'AssumeRole'.
arrAssumedRoleUser :: Lens' AssumeRoleResponse (Maybe AssumedRoleUser)
arrAssumedRoleUser =
    lens _arrAssumedRoleUser (\s a -> s { _arrAssumedRoleUser = a })

-- | The temporary security credentials, which include an access key ID, a secret
-- access key, and a security (or session) token.
arrCredentials :: Lens' AssumeRoleResponse (Maybe Credentials)
arrCredentials = lens _arrCredentials (\s a -> s { _arrCredentials = a })

-- | A percentage value that indicates the size of the policy in packed form. The
-- service rejects any policy with a packed size greater than 100 percent, which
-- means the policy exceeded the allowed space.
arrPackedPolicySize :: Lens' AssumeRoleResponse (Maybe Natural)
arrPackedPolicySize =
    lens _arrPackedPolicySize (\s a -> s { _arrPackedPolicySize = a })
        . mapping _Nat

instance ToPath AssumeRole where
    toPath = const "/"

instance ToQuery AssumeRole where
    toQuery AssumeRole{..} = mconcat
        [ "DurationSeconds" =? _arDurationSeconds
        , "ExternalId"      =? _arExternalId
        , "Policy"          =? _arPolicy
        , "RoleArn"         =? _arRoleArn
        , "RoleSessionName" =? _arRoleSessionName
        , "SerialNumber"    =? _arSerialNumber
        , "TokenCode"       =? _arTokenCode
        ]

instance ToHeaders AssumeRole

instance AWSRequest AssumeRole where
    type Sv AssumeRole = STS
    type Rs AssumeRole = AssumeRoleResponse

    request  = post "AssumeRole"
    response = xmlResponse

instance FromXML AssumeRoleResponse where
    parseXML = withElement "AssumeRoleResult" $ \x -> AssumeRoleResponse
        <$> x .@? "AssumedRoleUser"
        <*> x .@? "Credentials"
        <*> x .@? "PackedPolicySize"
