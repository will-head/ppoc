require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :controller do
  describe "POST #create" do
    let(:request_body) { 
      { data: { feed: source_feed } } 
    }

    before(:each) do
      post :create, :params => request_body
    end

    context "with basic feed" do
      let(:source_feed) { "http://example.com/feed" }

      it "returns itpc://example.com/feed" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://example.com/feed")
      end
    end

    context "with trailing slash feed" do
      let(:source_feed) { "http://example.com/feed/" }

      it "returns itpc://example.com/feed/" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://example.com/feed/")
      end
    end

    context "with secure feed" do
      let(:source_feed) { "https://example.com/feed" }

      it "returns itpc://example.com/feed" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://example.com/feed")
      end
    end

    context "with parameter in feed" do
      let(:source_feed) { "http://example.com/feed?rss" }

      it "returns itpc://example.com/feed?rss" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://example.com/feed?rss")
      end
    end

    context "with parameter equals in feed" do
      let(:source_feed) { "http://example.com/feed?format=rss" }

      it "returns itpc://example.com/feed?format=rss" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://example.com/feed?format=rss")
      end
    end

    context "with extension in feed" do
      let(:source_feed) { "http://example.com/feed.rss" }

      it "returns itpc://example.com/feed.rss" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://example.com/feed.rss")
      end
    end

    context "with username in feed" do
      let(:source_feed) { "http://user@example.com/feed" }

      it "returns itpc://user@example.com/feed" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://user@example.com/feed")
      end
    end

    context "with username and password in feed" do
      let(:source_feed) { "http://user:password@example.com/feed" }

      it "returns itpc://user:password@example.com/feed" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://user:password@example.com/feed")
      end
    end

    context "with different players" do
      let(:source_feed) { "http://example.com/feed" }

      it "returns http ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
