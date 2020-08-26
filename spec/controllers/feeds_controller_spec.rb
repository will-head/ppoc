require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  describe "POST #create" do
    let(:request_body) { 
      { data: { feed: "http://feeds.frackulous.com/frackulous/sd/" } } 
    }
   
    it "returns http ok" do
      post :create, :params => request_body
      expect(response).to have_http_status(:ok)
    end
  end
end
