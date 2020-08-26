module Api::V1
  class ApiController < ApplicationController
    before_action :set_headers

    protected

    def set_headers
      response.headers["Version"] = "V1"
    end
  end
end
