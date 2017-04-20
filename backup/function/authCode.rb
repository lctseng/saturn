#!/usr/bin/env ruby

$LOAD_PATH.push(File.dirname(File.expand_path(__FILE__)))
require 'General.rb'
require 'google/api_client'
require 'rest_client'
require 'id_token.rb'
require 'fileutils.rb'

def get_refresh_token(user_code)
    notify "處理使用者代碼：#{user_code}"
    fake_auth = Google::APIClient::ClientSecrets.load.to_authorization 
    fake_auth.scope = 'https://www.googleapis.com/auth/drive.file'
    json_data = RestClient.post(
        fake_auth.token_credential_uri.to_s,
        :code=>user_code,
        :client_id=>fake_auth.client_id,
        :client_secret=>fake_auth.client_secret,
        :redirect_uri=>fake_auth.redirect_uri.to_s,
        :grant_type=>'authorization_code') 
    auth = JSON.parse(json_data)
    notify auth.inspect
    token = auth["refresh_token"]
    notify "萃取的token：#{token}"
    return token
end




user_code = $stdin.readline
notify "新的使用者code：#{user_code}"
File.delete('_userCode') if File.exist?('_userCode')
File.open('_userCode','w') do |f|
   f.print(user_code)
end
FileUtils.chmod 0600,'_userCode'

begin
    refresh_token = get_refresh_token(user_code)
    if !refresh_token.nil? && !refresh_token.empty?
        notify "新的refresh token:#{refresh_token}"
        File.delete('_refreshToken') if File.exist?('_refreshToken')
        File.open('_refreshToken','w') do |f|
            f.print(refresh_token)
        end
        puts "成功紀錄認證資訊！您可以關閉此頁面。"
    end
    FileUtils.chmod 0600,'_refreshToken'
rescue
    puts "無法取得認證資訊！請聯絡網站管理員。"
end



