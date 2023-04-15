# frozen_string_literal: true

# BEGIN
require 'forwardable'
require 'uri'
require 'pry'

class Url
  attr_reader :url, :params

  include Comparable
  extend Forwardable
  
  def_delegators :@url, :scheme, :host, :port, :query

  def initialize(url)
    @url = URI(url)
    @params = {}

    return if @url.query.nil?

    @url.query.split('&').each do |pair|
      key, value = pair.split('=')
      @params[key.to_sym] = value
    end
  end

  def query_params
    @params
  end

  def query_param(key, default_value = nil)
    @params.fetch(key, default_value)
  end

  def to_s
    @url.to_s
  end

  def <=>(other)
    url_wo_query = @url.to_s.tr(@url.query || '', '')
    other_wo_query = other.to_s.tr(other.query || '', '')

    result = url_wo_query <=> other_wo_query
    @params <=> other.params if result.zero?
  end
end

# END
