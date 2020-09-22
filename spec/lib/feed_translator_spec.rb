require 'rails_helper'
# require 'feeds_translator'
require_relative "../../lib/feed_translator"

describe FeedTranslator do
  subject(:feed) { described_class.new(source_feed) }

  let(:source_feed) { "http://example.com/feed" }

  describe "#desktop" do
    it "includes :default key" do
      expect(feed.desktop).to have_key(:default)
    end

    it "includes :rss key" do
      expect(feed.desktop).to have_key(:rss)
    end

    it "includes :itunes key" do
      expect(feed.desktop).to have_key(:itunes)
    end

    it "includes :apple_podcasts key" do
      expect(feed.desktop).to have_key(:apple_podcasts)
    end
  end

  describe "#desktop[:default]" do
    it "[:feed_title] = 'Default'" do
      expect(feed.desktop[:default][:feed_title]).to eq("Default")
    end

    it "[:feed_url] = 'feed://example.com/feed'" do
      expect(feed.desktop[:default][:feed_url]).to eq("feed://example.com/feed")
    end
  end

  describe "#desktop[:rss]" do
    it "[:feed_title] = 'RSS'" do
      expect(feed.desktop[:rss][:feed_title]).to eq("RSS")
    end

    it "[:feed_url] = 'http://example.com/feed'" do
      expect(feed.desktop[:rss][:feed_url]).to eq("http://example.com/feed")
    end
  end

  describe "#desktop[:itunes]" do
    it "[:feed_title] = 'iTunes'" do
      expect(feed.desktop[:itunes][:feed_title]).to eq("iTunes")
    end

    it "[:feed_url] = 'itpc://example.com/feed'" do
      expect(feed.desktop[:itunes][:feed_url]).to eq("itpc://example.com/feed")
    end
  end

  describe "#desktop[:apple_podcasts]" do
    it "[:feed_title] = 'Apple Podcasts'" do
      expect(feed.desktop[:apple_podcasts][:feed_title]).to eq("Apple Podcasts")
    end

    it "[:feed_url] = 'podcast://example.com/feed'" do
      expect(feed.desktop[:apple_podcasts][:feed_url]).to eq("podcast://example.com/feed")
    end
  end

  describe "#ios" do
    it "includes :default key" do
      expect(feed.ios).to have_key(:default)
    end

    it "includes :apple_podcasts key" do
      expect(feed.ios).to have_key(:apple_podcasts)
    end

    it "includes :overcast key" do
      expect(feed.ios).to have_key(:overcast)
    end

    it "includes :castro key" do
      expect(feed.ios).to have_key(:castro)
    end

    it "includes :pocket_casts key" do
      expect(feed.ios).to have_key(:pocket_casts)
    end

    it "includes :downcast key" do
      expect(feed.ios).to have_key(:downcast)
    end
  end

  # describe "#http" do
  #   it "returns http://example.com/feed" do
  #     expect(feed.http).to eq("http://example.com/feed")
  #   end
  # end

  # describe "#feed" do
  #   it "returns feed://example.com/feed" do
  #     expect(feed.feed).to eq("feed://example.com/feed")
  #   end
  # end

  # describe "#itpc" do
  #   it "returns itpc://example.com/feed" do
  #     expect(feed.itpc).to eq("itpc://example.com/feed")
  #   end
  # end

  # describe "#podcast" do
  #   it "returns podcast://example.com/feed" do
  #     expect(feed.podcast).to eq("podcast://example.com/feed")
  #   end
  # end

  # describe "#pcast" do
  #   it "returns pcast://example.com/feed" do
  #     expect(feed.pcast).to eq("pcast://example.com/feed")
  #   end
  # end

  # describe "#castro" do
  #   it "returns castro://subscribe/example.com/feed" do
  #     expect(feed.castro).to eq("castro://subscribe/example.com/feed")
  #   end
  # end

  # describe "#pktc" do
  #   it "returns pktc://subscribe/example.com/feed" do
  #     expect(feed.pktc).to eq("pktc://subscribe/example.com/feed")
  #   end
  # end

  # describe "#downcast" do
  #   it "returns downcast://example.com/feed" do
  #     expect(feed.downcast).to eq("downcast://example.com/feed")
  #   end
  # end

  # describe "#overcast" do
  #   it "returns overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed" do
  #     expect(feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
  #   end
  # end

end
