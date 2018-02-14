#!/usr/bin/ruby

unless ENV['S3_BUCKET']
  puts "The environment variable S3_BUCKET has to be set"
  exit 1
end

DIRECTION = ENV['DIRECTION'] || 'UP'
SLEEP_SECONDS = ENV['SLEEP_SECONDS'].to_i || 30

$exclude_list = ""
EXCLUDE_DIRS.split(",").each do |exclude|
  $exclude_list += " --exclude \"*#{exclude}/*\""
end

def get_ts
  Time.now.utc.to_s
end

def up_sync
  puts `aws s3 sync #{$exclude_list} /sync s3://#{ENV['S3_BUCKET']}`
end


def sync
  start = Time.now
  puts "#{get_ts} starting sync"
  yield
  puts "#{get_ts} finished sync, took #{Time.now - start}"
end

loop do

  if DIRECTION.eql?("UP")
    sync {up_sync}
  end

  
  if (ONCE)
    break
  end
  
  sleep SLEEP_SECONDS
end
