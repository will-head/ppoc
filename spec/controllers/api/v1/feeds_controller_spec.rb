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

      it "returns json_body['status'] = 200" do
        expect(json_body["status"]).to eq(200)
      end

      it "returns json_body['request']['feed'] = http://example.com/feed" do
        expect(json_body["request"]["feed"]).to eq("http://example.com/feed")
      end
    end

    context "with invalid input 'not a valid feed'" do
      let(:source_feed) { "not a valid feed" }

      it "returns http ok" do
        expect(response).to have_http_status(:ok)
      end

      it "returns json_body['status'] = 422" do
        expect(json_body["status"]).to eq(422)
      end

      it "returns json_body['request']['feed'] = 'not a valid feed'" do
        expect(json_body["request"]["feed"]).to eq("not a valid feed")
      end
    end
  end
end
