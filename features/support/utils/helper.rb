require 'json'
require 'base64'

# Helper class.
# Author: Daniel Montecinos, Pablo Ramirez.
class Helper
  def self.pretty_json(json_string)
    JSON.pretty_generate(JSON[json_string])
  end

  def self.encode_credentials(credentials)
    Base64.encode64(credentials)
  end

  # Daniel Montecinos
  def self.build_endpoint(endpoint, key = '', response = {})
    if endpoint.include?('{')
      parsed_response = parse_to_json(response)

      invalid_id = SecureRandom.hex(12)
      value = parsed_response.key?(key) ? parsed_response[key] : invalid_id

      return endpoint.gsub(/\{\w+\}/, value)
    end
    endpoint
  end

  # Daniel Montecinos
  def self.get_value(key, response_body)
    parse_to_json(response_body)[key]
  end

  # Daniel Montecinos
  def self.parse_to_json(object)
    JSON.parse(object)
  end

  def self.timer(timeout)
    sleep timeout
  end
end
