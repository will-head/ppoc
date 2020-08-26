require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :controller do
  describe "POST #create" do
    let(:request_body) { 
      { data: { feed: "http://feeds.frackulous.com/frackulous/sd/" } } 
    }
   
    it "returns http ok" do
      post :create, :params => request_body
      expect(response).to have_http_status(:ok)
    end

    it "has a request, desktop, ios and android keys" do
      post :create, :params => request_body
      expect(JSON.parse(response.body).keys).to contain_exactly("request", "desktop", "ios", "android")
    end
  end
end
