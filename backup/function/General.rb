#!/usr/bin/env ruby

require 'rest_client'


def notify(*args)
   File.open("Log","a") do |f|
      f.puts(*args)
   end
end


# trim file path to directory path
def trim_to_dir_path(path)
   return path.slice(%r{/([^/]+/)+}) || '/'
end


# Extract access token 
def access_token_extract(access_t_str)
   return access_t_str.slice(%r{access_token:([^,\n\t {}]*)},1)
end


