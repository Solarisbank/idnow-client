# frozen_string_literal: true

module Idnow
  module API
    module Authentication
      def login
        path = full_path_for('login')
        login_data = Idnow::LoginData.new(@api_key)
        request = Idnow::PostJsonRequest.new(path, login_data)
        response = execute(request)
        @auth_token = Idnow::Login.new(response.data).auth_token
      end
    end
  end
end
