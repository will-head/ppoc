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

    it "non-version returns latest api" do
      # post '/api/feeds', :params => request_body
      expect(:post => "/api/feeds", :params => request_body).to route_to("api/v1/feeds#create")
    end
  end
end
