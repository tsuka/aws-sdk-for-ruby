# Copyright 2011 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

require 'aws/http/request'
require 'aws/authorize_v2'
require 'aws/authorize_with_session_token'

module AWS
  class SQS

    # @private
    class Request < AWS::Http::Request

      include AuthorizeV2
      include AuthorizeWithSessionToken

      def path
        full_url.path
      end

      def host
        full_url.host
      end

      private
      def full_url
        if url_param = params.find { |p| p.name == "QueueUrl" }
          URI.parse(url_param.value)
        else
          URI::HTTP.build(:host => @host, :path => '/')
        end
      end

    end
  end
end