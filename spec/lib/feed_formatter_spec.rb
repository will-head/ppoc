require 'rails_helper'
require 'feed_formatter'
require 'feed_translator'

describe FeedFormatter do

  context "with http://example.com/feed" do 
    let(:source_feed) { "http://example.com/feed" }
    describe "#body" do
      it "includes :request key" do
        translated_feed = FeedTranslator.new(source_feed)
        formatted_feed = FeedFormatter.new(translated_feed)
        expect(formatted_feed.body).to have_key(:request)
      end
    end
  end
end
