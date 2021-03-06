module ApiHelpers
  def json_body
    JSON.parse(response.body)
  end
end

RSpec.configure do |config| 
  config.include ApiHelpers, type: :request
  config.include ApiHelpers, type: :controller
end
