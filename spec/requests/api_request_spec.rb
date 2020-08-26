require "rails_helper"

RSpec.describe "non-version api", :type => :request do
  let(:latest_version) { "V1" }
  let(:source_feed) { "http://example.com/feed" }
  let(:request_body) { 
    { data: { feed: source_feed } } 
  }

  it "redirects to latest version" do
    post "/api/feeds", :params => request_body
    expect(response.headers["Version"]).to eq(latest_version)
  end
end
