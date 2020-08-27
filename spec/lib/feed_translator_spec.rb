require 'rails_helper'
# require 'feeds_translator'
require_relative "../../lib/feed_translator"

describe FeedTranslator do
  subject(:feed) { described_class.new(source_feed) }

  let(:source_feed) { "http://example.com/feed" }

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

  describe "#downcast" do
    it "returns downcast://example.com/feed" do
      expect(feed.downcast).to eq("downcast://example.com/feed")
    end
  end

end
