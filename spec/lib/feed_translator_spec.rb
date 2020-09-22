require 'rails_helper'
# require 'feeds_translator'
require_relative "../../lib/feed_translator"

describe FeedTranslator do
  subject(:feed) { described_class.new(source_feed) }

  let(:source_feed) { "http://example.com/feed" }

  describe "#desktop" do
    it "includes default key" do
      # desktop = { :default => { :feed_title => "Default", :feed_url => "feed://example.com/feed" } }
      expect(feed.desktop).to have_key(:default)
    end
  end

  describe "#default" do
    it "returns hash with feed_title: 'Default' and feed_url: 'feed://example.com/feed'" do
      default = { :feed_title => "Default", :feed_url => "feed://example.com/feed" }
      expect(feed.default).to eq(default)
    end
  end

  describe "#http" do
    it "returns http://example.com/feed" do
      expect(feed.http).to eq("http://example.com/feed")
    end
  end

  describe "#feed" do
    it "returns feed://example.com/feed" do
      expect(feed.feed).to eq("feed://example.com/feed")
    end
  end

  describe "#itpc" do
    it "returns itpc://example.com/feed" do
      expect(feed.itpc).to eq("itpc://example.com/feed")
    end
  end

  describe "#podcast" do
    it "returns podcast://example.com/feed" do
      expect(feed.podcast).to eq("podcast://example.com/feed")
    end
  end

  describe "#pcast" do
    it "returns pcast://example.com/feed" do
      expect(feed.pcast).to eq("pcast://example.com/feed")
    end
  end

  describe "#castro" do
    it "returns castro://subscribe/example.com/feed" do
      expect(feed.castro).to eq("castro://subscribe/example.com/feed")
    end
  end

  describe "#pktc" do
    it "returns pktc://subscribe/example.com/feed" do
      expect(feed.pktc).to eq("pktc://subscribe/example.com/feed")
    end
  end

  describe "#downcast" do
    it "returns downcast://example.com/feed" do
      expect(feed.downcast).to eq("downcast://example.com/feed")
    end
  end

  describe "#overcast" do
    it "returns overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed" do
      expect(feed.overcast).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
    end
  end

end
