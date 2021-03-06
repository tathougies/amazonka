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

-- Module      : Network.AWS.SWF.StartWorkflowExecution
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

-- | Starts an execution of the workflow type in the specified domain using the
-- provided 'workflowId' and input data.
--
-- This action returns the newly started workflow execution.
--
-- Access Control
--
-- You can use IAM policies to control this action's access to Amazon SWF
-- resources as follows:
--
-- Use a 'Resource' element with the domain name to limit the action to only
-- specified domains. Use an 'Action' element to allow or deny permission to call
-- this action. Constrain the following parameters by using a 'Condition' element
-- with the appropriate keys.   'tagList.member.0': The key is 'swf:tagList.member.0'
-- .  'tagList.member.1': The key is 'swf:tagList.member.1'.  'tagList.member.2': The
-- key is 'swf:tagList.member.2'.  'tagList.member.3': The key is 'swf:tagList.member.3'.  'tagList.member.4': The key is 'swf:tagList.member.4'. 'taskList': String
-- constraint. The key is 'swf:taskList.name'. 'workflowType.name': String
-- constraint. The key is 'swf:workflowType.name'. 'workflowType.version': String
-- constraint. The key is 'swf:workflowType.version'.    If the caller does not
-- have sufficient permissions to invoke the action, or the parameter values
-- fall outside the specified constraints, the action fails. The associated
-- event attribute's cause parameter will be set to OPERATION_NOT_PERMITTED. For
-- details and example IAM policies, see <http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html Using IAM to Manage Access to AmazonSWF Workflows>.
--
-- <http://docs.aws.amazon.com/amazonswf/latest/apireference/API_StartWorkflowExecution.html>
module Network.AWS.SWF.StartWorkflowExecution
    (
    -- * Request
      StartWorkflowExecution
    -- ** Request constructor
    , startWorkflowExecution
    -- ** Request lenses
    , swe1ChildPolicy
    , swe1Domain
    , swe1ExecutionStartToCloseTimeout
    , swe1Input
    , swe1TagList
    , swe1TaskList
    , swe1TaskPriority
    , swe1TaskStartToCloseTimeout
    , swe1WorkflowId
    , swe1WorkflowType

    -- * Response
    , StartWorkflowExecutionResponse
    -- ** Response constructor
    , startWorkflowExecutionResponse
    -- ** Response lenses
    , swerRunId
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.SWF.Types
import qualified GHC.Exts

data StartWorkflowExecution = StartWorkflowExecution
    { _swe1ChildPolicy                  :: Maybe ChildPolicy
    , _swe1Domain                       :: Text
    , _swe1ExecutionStartToCloseTimeout :: Maybe Text
    , _swe1Input                        :: Maybe Text
    , _swe1TagList                      :: List "tagList" Text
    , _swe1TaskList                     :: Maybe TaskList
    , _swe1TaskPriority                 :: Maybe Text
    , _swe1TaskStartToCloseTimeout      :: Maybe Text
    , _swe1WorkflowId                   :: Text
    , _swe1WorkflowType                 :: WorkflowType
    } deriving (Eq, Read, Show)

-- | 'StartWorkflowExecution' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'swe1ChildPolicy' @::@ 'Maybe' 'ChildPolicy'
--
-- * 'swe1Domain' @::@ 'Text'
--
-- * 'swe1ExecutionStartToCloseTimeout' @::@ 'Maybe' 'Text'
--
-- * 'swe1Input' @::@ 'Maybe' 'Text'
--
-- * 'swe1TagList' @::@ ['Text']
--
-- * 'swe1TaskList' @::@ 'Maybe' 'TaskList'
--
-- * 'swe1TaskPriority' @::@ 'Maybe' 'Text'
--
-- * 'swe1TaskStartToCloseTimeout' @::@ 'Maybe' 'Text'
--
-- * 'swe1WorkflowId' @::@ 'Text'
--
-- * 'swe1WorkflowType' @::@ 'WorkflowType'
--
startWorkflowExecution :: Text -- ^ 'swe1Domain'
                       -> Text -- ^ 'swe1WorkflowId'
                       -> WorkflowType -- ^ 'swe1WorkflowType'
                       -> StartWorkflowExecution
startWorkflowExecution p1 p2 p3 = StartWorkflowExecution
    { _swe1Domain                       = p1
    , _swe1WorkflowId                   = p2
    , _swe1WorkflowType                 = p3
    , _swe1TaskList                     = Nothing
    , _swe1TaskPriority                 = Nothing
    , _swe1Input                        = Nothing
    , _swe1ExecutionStartToCloseTimeout = Nothing
    , _swe1TagList                      = mempty
    , _swe1TaskStartToCloseTimeout      = Nothing
    , _swe1ChildPolicy                  = Nothing
    }

-- | If set, specifies the policy to use for the child workflow executions of this
-- workflow execution if it is terminated, by calling the 'TerminateWorkflowExecution' action explicitly or due to an expired timeout. This policy overrides the
-- default child policy specified when registering the workflow type using 'RegisterWorkflowType'.
--
-- The supported child policies are:
--
-- TERMINATE: the child executions will be terminated. REQUEST_CANCEL: a
-- request to cancel will be attempted for each child execution by recording a 'WorkflowExecutionCancelRequested' event in its history. It is up to the decider to take appropriate actions
-- when it receives an execution history with this event. ABANDON: no action
-- will be taken. The child executions will continue to run.  A child policy for
-- this workflow execution must be specified either as a default for the
-- workflow type or through this parameter. If neither this parameter is set nor
-- a default child policy was specified at registration time then a fault will
-- be returned.
swe1ChildPolicy :: Lens' StartWorkflowExecution (Maybe ChildPolicy)
swe1ChildPolicy = lens _swe1ChildPolicy (\s a -> s { _swe1ChildPolicy = a })

-- | The name of the domain in which the workflow execution is created.
swe1Domain :: Lens' StartWorkflowExecution Text
swe1Domain = lens _swe1Domain (\s a -> s { _swe1Domain = a })

-- | The total duration for this workflow execution. This overrides the
-- defaultExecutionStartToCloseTimeout specified when registering the workflow
-- type.
--
-- The duration is specified in seconds; an integer greater than or equal to 0.
-- Exceeding this limit will cause the workflow execution to time out. Unlike
-- some of the other timeout parameters in Amazon SWF, you cannot specify a
-- value of "NONE" for this timeout; there is a one-year max limit on the time
-- that a workflow execution can run.
--
-- An execution start-to-close timeout must be specified either through this
-- parameter or as a default when the workflow type is registered. If neither
-- this parameter nor a default execution start-to-close timeout is specified, a
-- fault is returned.
swe1ExecutionStartToCloseTimeout :: Lens' StartWorkflowExecution (Maybe Text)
swe1ExecutionStartToCloseTimeout =
    lens _swe1ExecutionStartToCloseTimeout
        (\s a -> s { _swe1ExecutionStartToCloseTimeout = a })

-- | The input for the workflow execution. This is a free form string which should
-- be meaningful to the workflow you are starting. This 'input' is made available
-- to the new workflow execution in the 'WorkflowExecutionStarted' history event.
swe1Input :: Lens' StartWorkflowExecution (Maybe Text)
swe1Input = lens _swe1Input (\s a -> s { _swe1Input = a })

-- | The list of tags to associate with the workflow execution. You can specify a
-- maximum of 5 tags. You can list workflow executions with a specific tag by
-- calling 'ListOpenWorkflowExecutions' or 'ListClosedWorkflowExecutions' and
-- specifying a 'TagFilter'.
swe1TagList :: Lens' StartWorkflowExecution [Text]
swe1TagList = lens _swe1TagList (\s a -> s { _swe1TagList = a }) . _List

-- | The task list to use for the decision tasks generated for this workflow
-- execution. This overrides the 'defaultTaskList' specified when registering the
-- workflow type.
--
-- A task list for this workflow execution must be specified either as a
-- default for the workflow type or through this parameter. If neither this
-- parameter is set nor a default task list was specified at registration time
-- then a fault will be returned. The specified string must not start or end
-- with whitespace. It must not contain a ':' (colon), '/' (slash), '|' (vertical
-- bar), or any control characters (\u0000-\u001f | \u007f - \u009f). Also, it
-- must not contain the literal string quotarnquot.
swe1TaskList :: Lens' StartWorkflowExecution (Maybe TaskList)
swe1TaskList = lens _swe1TaskList (\s a -> s { _swe1TaskList = a })

-- | The task priority to use for this workflow execution. This will override any
-- default priority that was assigned when the workflow type was registered. If
-- not set, then the default task priority for the workflow type will be used.
-- Valid values are integers that range from Java's 'Integer.MIN_VALUE'
-- (-2147483648) to 'Integer.MAX_VALUE' (2147483647). Higher numbers indicate
-- higher priority.
--
-- For more information about setting task priority, see <http://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html Setting Task Priority>
-- in the /Amazon Simple Workflow Developer Guide/.
swe1TaskPriority :: Lens' StartWorkflowExecution (Maybe Text)
swe1TaskPriority = lens _swe1TaskPriority (\s a -> s { _swe1TaskPriority = a })

-- | Specifies the maximum duration of decision tasks for this workflow execution.
-- This parameter overrides the 'defaultTaskStartToCloseTimout' specified when
-- registering the workflow type using 'RegisterWorkflowType'.
--
-- The duration is specified in seconds; an integer greater than or equal to 0.
-- The value "NONE" can be used to specify unlimited duration.
--
-- A task start-to-close timeout for this workflow execution must be specified
-- either as a default for the workflow type or through this parameter. If
-- neither this parameter is set nor a default task start-to-close timeout was
-- specified at registration time then a fault will be returned.
swe1TaskStartToCloseTimeout :: Lens' StartWorkflowExecution (Maybe Text)
swe1TaskStartToCloseTimeout =
    lens _swe1TaskStartToCloseTimeout
        (\s a -> s { _swe1TaskStartToCloseTimeout = a })

-- | The user defined identifier associated with the workflow execution. You can
-- use this to associate a custom identifier with the workflow execution. You
-- may specify the same identifier if a workflow execution is logically a /restart/
-- of a previous execution. You cannot have two open workflow executions with
-- the same 'workflowId' at the same time.
--
-- The specified string must not start or end with whitespace. It must not
-- contain a ':' (colon), '/' (slash), '|' (vertical bar), or any control characters
-- (\u0000-\u001f | \u007f - \u009f). Also, it must not contain the literal
-- string quotarnquot.
swe1WorkflowId :: Lens' StartWorkflowExecution Text
swe1WorkflowId = lens _swe1WorkflowId (\s a -> s { _swe1WorkflowId = a })

-- | The type of the workflow to start.
swe1WorkflowType :: Lens' StartWorkflowExecution WorkflowType
swe1WorkflowType = lens _swe1WorkflowType (\s a -> s { _swe1WorkflowType = a })

newtype StartWorkflowExecutionResponse = StartWorkflowExecutionResponse
    { _swerRunId :: Maybe Text
    } deriving (Eq, Ord, Read, Show, Monoid)

-- | 'StartWorkflowExecutionResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'swerRunId' @::@ 'Maybe' 'Text'
--
startWorkflowExecutionResponse :: StartWorkflowExecutionResponse
startWorkflowExecutionResponse = StartWorkflowExecutionResponse
    { _swerRunId = Nothing
    }

-- | The 'runId' of a workflow execution. This Id is generated by the service and
-- can be used to uniquely identify the workflow execution within a domain.
swerRunId :: Lens' StartWorkflowExecutionResponse (Maybe Text)
swerRunId = lens _swerRunId (\s a -> s { _swerRunId = a })

instance ToPath StartWorkflowExecution where
    toPath = const "/"

instance ToQuery StartWorkflowExecution where
    toQuery = const mempty

instance ToHeaders StartWorkflowExecution

instance ToJSON StartWorkflowExecution where
    toJSON StartWorkflowExecution{..} = object
        [ "domain"                       .= _swe1Domain
        , "workflowId"                   .= _swe1WorkflowId
        , "workflowType"                 .= _swe1WorkflowType
        , "taskList"                     .= _swe1TaskList
        , "taskPriority"                 .= _swe1TaskPriority
        , "input"                        .= _swe1Input
        , "executionStartToCloseTimeout" .= _swe1ExecutionStartToCloseTimeout
        , "tagList"                      .= _swe1TagList
        , "taskStartToCloseTimeout"      .= _swe1TaskStartToCloseTimeout
        , "childPolicy"                  .= _swe1ChildPolicy
        ]

instance AWSRequest StartWorkflowExecution where
    type Sv StartWorkflowExecution = SWF
    type Rs StartWorkflowExecution = StartWorkflowExecutionResponse

    request  = post "StartWorkflowExecution"
    response = jsonResponse

instance FromJSON StartWorkflowExecutionResponse where
    parseJSON = withObject "StartWorkflowExecutionResponse" $ \o -> StartWorkflowExecutionResponse
        <$> o .:? "runId"
