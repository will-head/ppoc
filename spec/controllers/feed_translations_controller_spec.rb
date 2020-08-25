require 'rails_helper'

RSpec.describe FeedTranslationsController, type: :controller do

  describe "GET #feeds" do
    let(:request_body) { 
      { "data": { "feed": "http://feeds.frackulous.com/frackulous/sd/" } } 
    }

    it "returns http success" do
      post :feeds, :params => request_body
      expect(response).to have_http_status(:success)
    end
  end

end
