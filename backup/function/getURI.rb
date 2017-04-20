#!/usr/bin/env ruby
require 'google/api_client'

def getURI
    auth = Google::APIClient::ClientSecrets.load.to_authorization
    auth.scope = 'https://www.googleapis.com/auth/drive.file'
    return auth.authorization_uri
end

puts getURI

