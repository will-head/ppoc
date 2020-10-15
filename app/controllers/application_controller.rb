class ApplicationController < ActionController::API
  force_ssl unless: -> { Rails.env.in? ['development', 'test'] }
end
