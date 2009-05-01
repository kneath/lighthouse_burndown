$:.unshift File.expand_path(File.dirname(__FILE__))

require "json"
require "dm-core"
require "dm-validations"
require "dm-types"
require "dm-aggregates"
require "dm-timestamps"
require "sinatra/base"

require "yaml"
require "logger"
require "digest/sha1"
require "ostruct"
require "httparty"

require "burndown/helpers"
require "burndown/lighthouse"
require "burndown/project"
require "burndown/milestone"
require "burndown/milestone_event"
require "burndown/token"
require "burndown/app"

module Burndown
  def self.new(config=nil)
    if config.is_a?(String) && File.file?(config)
      self.config = YAML.load_file(config)
    elsif config.is_a?(Hash)
      self.config = config
    end
    
    self.config[:demo_mode] = ENV['DEMO_MODE'] || self.config[:demo_mode]

    DataMapper.setup(:default, ENV['DATABASE_URL'] || self.config[:database_uri])
    DataMapper.auto_upgrade!
  end
  
  def self.default_configuration
    @defaults ||= { :database_uri      => "sqlite3::memory:",
                    :log               => STDOUT,
                    :base_uri          => "http://localhost:8910",
                    :lighthouse_host   => "lighthouseapp.com",
                    :demo_mode         => false,
                    :log_debug_info    => false }
  end

  def self.config
    @config ||= default_configuration.dup
  end

  def self.config=(options)
    @config = default_configuration.merge(options)
  end

  def self.log(message, &block)
    logger.info(message, &block)
  end

  def self.logger
    @logger ||= Logger.new(config[:log], "daily").tap do |logger|
      logger.formatter = LogFormatter.new
    end
  end
  private_class_method :logger

  class LogFormatter < Logger::Formatter
    def call(severity, time, progname, msg)
      time.strftime("[%H:%M:%S] ") + msg2str(msg) + "\n"
    end
  end
end