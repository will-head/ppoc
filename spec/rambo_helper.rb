require "rails_helper"
require "rack/test"
require_relative "./support/matchers/rambo_matchers"

module ApiHelper
  include Rack::Test::Methods

  def app
    require "active_support/core_ext/class/subclasses"
    Rails.application
  end
end

RSpec.configure do |config|
  config.include ApiHelper, type: :rambo
end