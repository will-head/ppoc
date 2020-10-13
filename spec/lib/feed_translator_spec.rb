require 'rails_helper'
require 'feed_translator'

describe FeedTranslator do
  subject(:feed) { described_class.new(source_feed) }

  context "with valid input" do 
    describe "http scheme" do 
      let(:source_feed) { "http://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "https scheme" do 
      let(:source_feed) { "https://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=https%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "feed scheme" do 
      let(:source_feed) { "feed://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected feed format" do
        expect(feed.body[:desktop][:rss][:feed_url]).to eq("http://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end

    end

    describe "itpc scheme" do 
      let(:source_feed) { "itpc://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "podcast scheme" do 
      let(:source_feed) { "podcast://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "overcast scheme" do 
      let(:source_feed) { "overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "castro scheme" do 
      let(:source_feed) { "castro://subscribe/example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "pktc scheme" do 
      let(:source_feed) { "pktc://subscribe/example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "downcast scheme" do 
      let(:source_feed) { "downcast://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "pcast scheme" do 
      let(:source_feed) { "pcast://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

  end

  context "with invalid input" do 
    describe "not a string" do 
      let(:source_feed) { nil }

      it "returns false" do 
        expect(feed.valid_request?).to eq(false)
      end
    end

    describe "empty string" do 
      let(:source_feed) { "" }

      it "returns false" do 
        expect(feed.valid_request?).to eq(false)
      end
    end

    describe "invalid characters" do 
      let(:source_feed) { "http:// <not valid>" }

      it "returns false" do 
        expect(feed.valid_request?).to eq(false)
      end
    end

    describe "invalid scheme" do 
      let(:source_feed) { "invalidscheme://example.com/feed" }

      it "returns false" do 
        expect(feed.valid_request?).to eq(false)
      end
    end

    describe "invalid castro feed" do 
      let(:source_feed) { "castro://example.com/feed" }

      it "returns false" do 
        expect(feed.valid_request?).to eq(false)
      end
    end

    describe "invalid pktc feed" do 
      let(:source_feed) { "pktc://example.com/feed" }

      it "returns false" do 
        expect(feed.valid_request?).to eq(false)
      end
    end
  end
end
