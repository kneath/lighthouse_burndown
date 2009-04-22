#!/usr/bin/env ruby
require "rubygems"
require "lib/burndown"

# Load configuration and initialize Burndown
Burndown.new(File.dirname(__FILE__) + "/config/config.yml")

# You probably don't want to edit anything below
Burndown::App.set :environment, ENV["RACK_ENV"] || :production
Burndown::App.set :port,        8910

run Burndown::App
