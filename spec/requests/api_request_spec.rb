require "rails_helper"

RSpec.describe "non-version api", :type => :request do
  let(:request_body) { 
    { data: { feed: "http://feeds.frackulous.com/frackulous/sd/" } } 
  }

  it "redirects to latest version" do
    post "/api/feeds", :params => request_body
    expect(response).to have_http_status(:ok)
  end
end
