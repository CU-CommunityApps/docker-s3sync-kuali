#!/usr/bin/ruby

unless ENV['S3_BUCKET']
  puts "The environment variable S3_BUCKET has to be set"
  exit 1
end

DIRECTION = ENV['DIRECTION'] || 'UP'
SLEEP_SECONDS = ENV['SLEEP_SECONDS'].to_i || 30


def get_ts
  Time.now.utc.to_s
end

def up_sync
  puts `aws s3 sync /sync s3://#{ENV['S3_BUCKET']}`
end

def dn_sync
  puts `aws s3 sync s3://#{ENV['S3_BUCKET']} /sync`
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

  if DIRECTION.eql?("DN")
    sync {df_sync}
  end

  
  sleep SLEEP_SECONDS
end
