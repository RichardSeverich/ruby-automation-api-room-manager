# Author: Pablo Ramirez
module Hooks_helper

  def self.build_request(body, endpoint, method)
    @http = HttpRequest.new("/#{endpoint}")
    @http.add_body(body.to_json)
    @http.add_method method
  end

  def self.request_post_hook(method, endpoint, value, key_header = Env.key_header_rm,
                        value_header = Helper.encode_credentials(Env.user_password), host, body)

    response = $db_es.find_element endpoint, value, host

    if response.to_h.empty?
      build_request body, endpoint, method
      @http.add_header_field key_header, value_header
      @http.build_url
      Helper.timer Env.timer
      RequestManager.execute_request @http
    end
  end
end