require "rails_helper"

RSpec.describe "non-version api", :type => :request do
  before(:each) { host! "api.example.com" }
  
  let(:latest_version) { "V1" }
  let(:source_feed) { "http://example.com/feed" }
  let(:request_body) { 
    { data: { feed: source_feed } } 
  }

  it "redirects to latest version" do
    post "/feeds", :params => request_body
    expect(response.headers["Version"]).to eq(latest_version)
  end
end
