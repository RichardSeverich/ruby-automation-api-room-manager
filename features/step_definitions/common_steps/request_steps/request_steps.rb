# Author: Daniel Montecinos, Pablo Ramirez

require_relative '../../../../features/support/utils/http_request'
require_relative '../../../../features/support/utils/request_manager'
require_relative '../../../../features/support/utils/helper'

include RSpec::Matchers

Given(/^I make a '(\w+)' request to '(.+)'$/) do |method, endpoint|
  @http = HttpRequest.new(Helper.build_endpoint(endpoint, @key, @json))
  @http.add_method(method)
end

And(/^I set this queries:$/) do |queries|
  @http.add_header_query(queries.rows_hash)
end

And(/^I set this headers?:$/) do |headers|
  headers.rows_hash.each {|key, value| @http.add_header_field(key, value)}
end

When(/^I execute the request$/) do
  @http.build_url
  @json = RequestManager.execute_request(@http)
end

Then(/^I expect a '(\d+)' status code$/) do |status_code_expected|
  expect(@json.code).to eql(status_code_expected.to_i)
end

And(/^a response body as:$/) do |body_expected|
  expect(@json.body).to be_json_eql(body_expected).excluding('_id')
end

And(/^I set this body:$/) do |json|
  @http.add_body(json)
  @body = Helper.parse_to_json(json)
end

Then(/^I store the '(_?\w+)' as '(?:.+)'$/) do |key|
  @value = Helper.get_value(key, @json.body)
  @key = key
end

# Author: Daniel Montecinos
And(/^after build a expected response with the fields:$/) do |table|
  @built_response = {}
  table.transpose.column_names.each do |field|
    Helper.parse_to_json(@json.body).each do |key, value|
      @built_response.store(key, value) if key.eql?(field)
    end
  end
end

# Author: Daniel Montecinos
And(/^the built response should be equal to the obtained response$/) do
  expect(@built_response.to_json).to be_json_eql(@last_json.body)
end

# Author: Pablo Ramirez
Given(/^I have obtained roomsId for '([^\n]+)' from '(\w+)' of the table '(\w+)'$/) do |value, key, endpoint|
  @bson = @db_rm.find_element(endpoint, key, value)
  @json = Helper.get_value('_id', @bson.to_json).to_json
  @key = '$oid'
end

And(/^I store the response$/) do
  @last_json = @json
end

# Author: Daniel Montecinos
And(/^the response should( not)? include the field "(\w+)"$/) do |fld, negative|
  answer = Helper.parse_to_json(@json.body).key?(fld)

  !answer if negative
end

And(/^the '(_\w+)' value should remain unchanged$/) do |key|
  expect(Helper.get_value(key, @json.body)).to eql(@value)
end

# Author: Daniel Montecinos
And(/^I change the "(key|value)" of "(.+)" to "(.*)"$/) do |type, key, argument|
  if type.eql?('key')
    @http.change_header_key(key, argument)
  else
    @http.change_key_value(key, argument)
  end
end

# Author: Daniel Montecinos
And(/^I construct a expected response adding this fields:$/) do |fields|
  fields.transpose.column_names.each do |field|
    value = Helper.get_value(field, @json.body)
    @body[field] = value
  end
end

# Author: Daniel Montecinos
And(/^the built expected response should be equal to the obtained response$/) do
  expect(@body.to_json).to be_json_eql(@json.body).excluding("rooms")
end

# Daniel Montecinos
And(/^I replace the values of the body request$/) do
  @body.map do |key, value|
    @body[key] = eval(value) if value.instance_of?(String)
  end
  @http.add_body(@body.to_json)
end

#Juan Aitken
And(/^I load exchange server credentials$/) do
  @http.change_header_key('Credentials', 'Exchange-Credentials')
end

#Juan Aitken
When(/^I set the headers:$/) do |headers|
  headers.rows_hash.each {|key, value| @http.change_header_key('', key)}
  headers.rows_hash.each {|key, value| @http.change_key_value(key,value)}
end