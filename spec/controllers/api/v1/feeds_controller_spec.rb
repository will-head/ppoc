require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :controller do
  describe "POST #create" do
    let(:request_body) { 
      { data: { feed: "http://feeds.frackulous.com/frackulous/sd/" } } 
    }

    before(:each) do
      post :create, :params => request_body
    end

    it "returns http ok" do
      expect(response).to have_http_status(:ok)
    end

    it "has a request, desktop, ios and android keys" do
      expect(json_body.keys).to contain_exactly("request", "desktop", "ios", "android")
    end
  end
end
