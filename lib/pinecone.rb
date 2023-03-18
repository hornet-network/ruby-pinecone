require "httparty"

require_relative "pinecone/client"
require_relative "pinecone/index"
require_relative "pinecone/vectors"
require_relative "pinecone/version"

module Pinecone
  class Error < StandardError; end
  class ConfigurationError < Error; end

  class Configuration
    attr_writer :api_key, :environment

    def initialize
      @api_key = nil
      @environment = nil
    end

    def api_key
      return @api_key if @api_key

      error_text = "Pinecone API Key missing! See https://github.com/hornet-network/ruby-pinecone#usage"
      raise ConfigurationError, error_text
    end

    def environment
      return @environment if @environment

      error_text = "Pinecone environment missing! See https://github.com/hornet-network/ruby-pinecone#usage"
      raise ConfigurationError, error_text
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Pinecone::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end