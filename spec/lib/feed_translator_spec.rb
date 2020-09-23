require 'rails_helper'
require 'feed_translator'

describe FeedTranslator do
  subject(:feed) { described_class.new(source_feed) }

  context "with http://example.com/feed" do 
    let(:source_feed) { "http://example.com/feed" }

    describe "#body" do
      it "includes :request key" do
        expect(feed.body).to have_key(:request)
      end

      it "includes :desktop key" do
        expect(feed.body).to have_key(:desktop)
      end

      it "includes :ios key" do
        expect(feed.body).to have_key(:ios)
      end

      it "includes :android key" do
        expect(feed.body).to have_key(:android)
      end
    end

    describe "#body[:request]" do
      it "[:feed] = 'http://example.com/feed'" do 
        expect(feed.body[:request][:feed]).to eq("http://example.com/feed")
      end
    end

    describe "#body[:desktop]" do
      it "includes :default key" do
        expect(feed.body[:desktop]).to have_key(:default)
      end

      it "includes :rss key" do
        expect(feed.body[:desktop]).to have_key(:rss)
      end

      it "includes :itunes key" do
        expect(feed.body[:desktop]).to have_key(:itunes)
      end

      it "includes :apple_podcasts key" do
        expect(feed.body[:desktop]).to have_key(:apple_podcasts)
      end
    end

    describe "#body[:desktop][:default]" do
      it "[:feed_title] = 'Default'" do
        expect(feed.body[:desktop][:default][:feed_title]).to eq("Default")
      end

      it "[:feed_url] = 'feed://example.com/feed'" do
        expect(feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end
    end

    describe "#body[:desktop][:rss]" do
      it "[:feed_title] = 'RSS'" do
        expect(feed.body[:desktop][:rss][:feed_title]).to eq("RSS")
      end

      it "[:feed_url] = 'http://example.com/feed'" do
        expect(feed.body[:desktop][:rss][:feed_url]).to eq("http://example.com/feed")
      end
    end

    describe "#body[:desktop][:itunes]" do
      it "[:feed_title] = 'iTunes'" do
        expect(feed.body[:desktop][:itunes][:feed_title]).to eq("iTunes")
      end

      it "[:feed_url] = 'itpc://example.com/feed'" do
        expect(feed.body[:desktop][:itunes][:feed_url]).to eq("itpc://example.com/feed")
      end
    end

    describe "#body[:desktop][:apple_podcasts]" do
      it "[:feed_title] = 'Apple Podcasts'" do
        expect(feed.body[:desktop][:apple_podcasts][:feed_title]).to eq("Apple Podcasts")
      end

      it "[:feed_url] = 'podcast://example.com/feed'" do
        expect(feed.body[:desktop][:apple_podcasts][:feed_url]).to eq("podcast://example.com/feed")
      end
    end

    describe "#body[:ios]" do
      it "includes :default key" do
        expect(feed.body[:ios]).to have_key(:default)
      end

      it "includes :apple_podcasts key" do
        expect(feed.body[:ios]).to have_key(:apple_podcasts)
      end

      it "includes :overcast key" do
        expect(feed.body[:ios]).to have_key(:overcast)
      end

      it "includes :castro key" do
        expect(feed.body[:ios]).to have_key(:castro)
      end

      it "includes :pocket_casts key" do
        expect(feed.body[:ios]).to have_key(:pocket_casts)
      end

      it "includes :downcast key" do
        expect(feed.body[:ios]).to have_key(:downcast)
      end
    end

    describe "#body[:ios][:default]" do
      it "[:feed_title] = 'Default'" do
        expect(feed.body[:ios][:default][:feed_title]).to eq("Default")
      end

      it "[:feed_url] = 'feed://example.com/feed'" do
        expect(feed.body[:ios][:default][:feed_url]).to eq("feed://example.com/feed")
      end
    end

    describe "#body[:ios][:apple_podcasts]" do
      it "[:feed_title] = 'Apple Podcasts'" do
        expect(feed.body[:ios][:apple_podcasts][:feed_title]).to eq("Apple Podcasts")
      end

      it "[:feed_url] = 'podcast://example.com/feed'" do
        expect(feed.body[:ios][:apple_podcasts][:feed_url]).to eq("podcast://example.com/feed")
      end
    end

    describe "#body[:ios][:overcast]" do
      it "[:feed_title] = 'Overcast'" do
        expect(feed.body[:ios][:overcast][:feed_title]).to eq("Overcast")
      end

      it "[:feed_url] = 'overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed'" do
        expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end
    end

    describe "#body[:ios][:castro]" do
      it "[:feed_title] = 'Castro'" do
        expect(feed.body[:ios][:castro][:feed_title]).to eq("Castro")
      end

      it "[:feed_url] = 'castro://subscribe/example.com/feed'" do
        expect(feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "#body[:ios][:pocket_casts]" do
      it "[:feed_title] = 'Pocket Casts'" do
        expect(feed.body[:ios][:pocket_casts][:feed_title]).to eq("Pocket Casts")
      end

      it "[:feed_url] = 'pktc://subscribe/example.com/feed'" do
        expect(feed.body[:ios][:pocket_casts][:feed_url]).to eq("pktc://subscribe/example.com/feed")
      end
    end

    describe "#body[:ios][:downcast]" do
      it "[:feed_title] = 'Downcast'" do
        expect(feed.body[:ios][:downcast][:feed_title]).to eq("Downcast")
      end

      it "[:feed_url] = 'downcast://example.com/feed'" do
        expect(feed.body[:ios][:downcast][:feed_url]).to eq("downcast://example.com/feed")
      end
    end

    describe "#body[:android]" do
      it "includes :default key" do
        expect(feed.body[:android]).to have_key(:default)
      end
    end

    describe "#body[:android][:default]" do
      it "[:feed_title] = 'Default'" do
        expect(feed.body[:android][:default][:feed_title]).to eq("Default")
      end

      it "[:feed_url] = 'pcast://example.com/feed'" do
        expect(feed.body[:android][:default][:feed_url]).to eq("pcast://example.com/feed")
      end
    end
  end

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

      # it "returns expected format for overcast://" do
      #   expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      # end

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

      # it "returns expected format for overcast://" do
      #   expect(feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      # end

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
