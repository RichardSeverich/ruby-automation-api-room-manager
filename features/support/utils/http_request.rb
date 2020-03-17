require 'json'
require_relative 'helper'

# HttpRequest class.
# Author: Daniel Montecinos, Pablo Ramirez.
class HttpRequest
  attr_reader :header, :body, :method, :url

  def initialize(endpoint)
    credentials = Helper.encode_credentials(Env.user_password)

    @endpoint = endpoint
    @header = {
      :'Content-Type' => 'application/json',
      Credentials: credentials
    }
    @body = {}
  end

  # Daniel Montecinos
  # Use this method if you want to change the values set by default.
  def add_header_field(new_key, value)
    @header.store(new_key, value)
  end

  # Daniel Montecinos
  # This method allows to change the name of an old key to
  # a new one
  def change_header_key(old_key, new_key)
    @header[new_key.to_sym] = @header.delete(old_key.to_sym)
  end

  # Daniel Montecinos
  # This method allows to change the value of a key
  def change_key_value(key, value)
    @header[key.to_sym] = value
  end

  def add_header_query(query = {})
    @header[:params] = query
  end

  def add_body(body)
    @body = Helper.parse_to_json(body)
  end

  def add_method(method)
    @method = method
  end

  def build_url
    base_url = @header.key?(:'Exchange-Credentials') ? Env.exchanges : Env.room
    @url = "#{base_url}#{@endpoint}"
  end
end
