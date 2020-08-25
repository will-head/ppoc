require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  describe "POST #feed" do
    let(:request_body) { 
      { data: { feed: "http://feeds.frackulous.com/frackulous/sd/" } } 
    }
   
    it "returns http success" do
      post :feed, :params => request_body
      expect(response).to have_http_status(200)
    end
  end
end
