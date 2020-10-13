require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :controller do
  describe "POST #create" do
    let(:request_body) { 
      { data: { feed: source_feed } } 
    }

    before(:each) do
      post :create, :params => request_body
    end

    context "with valid input 'http://example.com/feed'" do
      let(:source_feed) { "http://example.com/feed" }

      it "returns http ok" do
        expect(response).to have_http_status(:ok)
      end

      it "returns itpc://example.com/feed" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://example.com/feed")
      end
    end

    context "with invalid input ''" do
      let(:source_feed) { "" }

      it "returns http unprocessable_entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      # it "returns itpc://example.com/feed" do
      #   expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://example.com/feed")
      # end
    end
  end
end
