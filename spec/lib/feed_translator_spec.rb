require 'rails_helper'
# require 'feeds_translator'
require_relative "../../lib/feed_translator"

describe FeedTranslator do
  subject(:feed) { described_class.new(source_feed) }

  let(:source_feed) { "http://example.com/feed" }

  describe "#rss" do
    it "returns http://example.com/feed" do
      expect(feed.rss).to eq("http://example.com/feed")
    end
  end
end
