#!/usr/bin/env ruby

$LOAD_PATH.push(File.dirname(File.expand_path(__FILE__)))

require 'GoogleDrive.rb'

input = $stdin.readline
src_path , target_path = input.split
drive = GoogleDrive.new
drive.create_folder_by_path(target_path)
drive.upload_all_in_path(src_path,target_path)

