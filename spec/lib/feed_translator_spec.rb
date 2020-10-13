require 'rails_helper'
require 'feed_translator'

describe FeedTranslator do
  subject(:translated_feed) { described_class.new(source_feed) }

  context "with different types of valid input" do
    describe "no trailing slash" do
      let(:source_feed) { "http://example.com/feed" }

      it "returns itpc://example.com/feed" do
        expect(translated_feed.itpc).to eq("itpc://example.com/feed")
      end
    end

    describe "with trailing slash feed" do
      let(:source_feed) { "http://example.com/feed/" }

      it "returns itpc://example.com/feed/" do
        expect(translated_feed.itpc).to eq("itpc://example.com/feed/")
      end
    end

    describe "with secure feed" do
      let(:source_feed) { "https://example.com/feed" }

      it "returns itpc://example.com/feed" do
        expect(translated_feed.itpc).to eq("itpc://example.com/feed")
      end
    end

    describe "with parameter in feed" do
      let(:source_feed) { "http://example.com/feed?rss" }

      it "returns itpc://example.com/feed?rss" do
        expect(translated_feed.itpc).to eq("itpc://example.com/feed?rss")
      end
    end

    describe "with parameter equals in feed" do
      let(:source_feed) { "http://example.com/feed?format=rss" }

      it "returns itpc://example.com/feed?format=rss" do
        expect(translated_feed.itpc).to eq("itpc://example.com/feed?format=rss")
      end
    end

    describe "with extension in feed" do
      let(:source_feed) { "http://example.com/feed.rss" }

      it "returns itpc://example.com/feed.rss" do
        expect(translated_feed.itpc).to eq("itpc://example.com/feed.rss")
      end
    end

    describe "with username in feed" do
      let(:source_feed) { "http://user@example.com/feed" }

      it "returns itpc://user@example.com/feed" do
        expect(translated_feed.itpc).to eq("itpc://user@example.com/feed")
      end
    end

    describe "with username and password in feed" do
      let(:source_feed) { "http://user:password@example.com/feed" }

      it "returns itpc://user:password@example.com/feed" do
        expect(translated_feed.itpc).to eq("itpc://user:password@example.com/feed")
      end
    end
  end

  context "with different valid input schemes" do 
    describe "http" do 
      let(:source_feed) { "http://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(translated_feed.feed).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "https" do 
      let(:source_feed) { "https://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(translated_feed.feed).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=https%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "feed" do 
      let(:source_feed) { "feed://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected feed format" do
        expect(translated_feed.http).to eq("http://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end

    end

    describe "itpc" do 
      let(:source_feed) { "itpc://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(translated_feed.feed).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "podcast" do 
      let(:source_feed) { "podcast://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(translated_feed.feed).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "overcast" do 
      let(:source_feed) { "overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(translated_feed.feed).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "castro" do 
      let(:source_feed) { "castro://subscribe/example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(translated_feed.feed).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "pktc" do 
      let(:source_feed) { "pktc://subscribe/example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(translated_feed.feed).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "downcast" do 
      let(:source_feed) { "downcast://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(translated_feed.feed).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "pcast" do 
      let(:source_feed) { "pcast://example.com/feed" }

      it "valid_request? doesn't return false" do 
        expect(translated_feed.valid_request?).not_to eq(false)
      end

      it "returns expected format for feed://" do
        expect(translated_feed.feed).to eq("feed://example.com/feed")
      end

      it "returns expected format for overcast://" do
        expect(translated_feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end

      it "returns expected format for castro://" do
        expect(translated_feed.castro).to eq("castro://subscribe/example.com/feed")
      end
    end
  end

  context "with invalid input" do 
    describe "not a string" do 
      let(:source_feed) { nil }

      it "returns false" do 
        expect(translated_feed.valid_request?).to eq(false)
      end
    end

    describe "empty string" do 
      let(:source_feed) { "" }

      it "returns false" do 
        expect(translated_feed.valid_request?).to eq(false)
      end
    end

    describe "invalid characters" do 
      let(:source_feed) { "http:// <not valid>" }

      it "returns false" do 
        expect(translated_feed.valid_request?).to eq(false)
      end
    end

    describe "invalid scheme" do 
      let(:source_feed) { "invalidscheme://example.com/feed" }

      it "returns false" do 
        expect(translated_feed.valid_request?).to eq(false)
      end
    end

    describe "invalid castro feed" do 
      let(:source_feed) { "castro://example.com/feed" }

      it "returns false" do 
        expect(translated_feed.valid_request?).to eq(false)
      end
    end

    describe "invalid pktc feed" do 
      let(:source_feed) { "pktc://example.com/feed" }

      it "returns false" do 
        expect(translated_feed.valid_request?).to eq(false)
      end
    end
  end
end
