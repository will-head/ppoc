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

    context "with different podcast players" do
      let(:source_feed) { "http://example.com/feed" }

      it "returns http ok" do
        expect(response).to have_http_status(:ok)
      end

      it "has request, desktop, ios and android keys" do
        expect(json_body.keys).to contain_exactly("request", "desktop", "ios", "android")
      end

      it "request has a feed key" do
        expect(json_body["request"].keys).to contain_exactly("feed")
      end

      it "request feed value is http://example.com/feed" do
        expect(json_body["request"]["feed"]).to eq("http://example.com/feed")
      end

      it "desktop key has rss, itunes and apple_podcasts keys" do
        expect(json_body["desktop"].keys).to contain_exactly("rss", "itunes", "apple_podcasts")
      end

      it "desktop rss key has feed_title and feed_url keys" do
        expect(json_body["desktop"]["rss"].keys).to contain_exactly("feed_title", "feed_url")
      end

      it "desktop rss feed_title value is RSS" do
        expect(json_body["desktop"]["rss"]["feed_title"]).to eq("RSS")
      end

      it "desktop rss feed_url value is http://example.com/feed" do
        expect(json_body["desktop"]["rss"]["feed_url"]).to eq("http://example.com/feed")
      end

      it "desktop itunes feed_title value is iTunes" do
        expect(json_body["desktop"]["itunes"]["feed_title"]).to eq("iTunes")
      end

      it "desktop itunes feed_url value is itpc://example.com/feed" do
        expect(json_body["desktop"]["itunes"]["feed_url"]).to eq("itpc://example.com/feed")
      end

      it "desktop apple_podcasts feed_title value is Apple Podcasts" do
        expect(json_body["desktop"]["apple_podcasts"]["feed_title"]).to eq("Apple Podcasts")
      end

      it "desktop apple_podcasts feed_url value is podcast://example.com/feed" do
        expect(json_body["desktop"]["apple_podcasts"]["feed_url"]).to eq("podcast://example.com/feed")
      end
    end
  end
end
