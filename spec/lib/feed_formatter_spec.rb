require 'rails_helper'
require 'feed_formatter'

describe FeedFormatter do

  context "with translated feed: http://example.com/feed" do 
    subject(:formatted_feed) { described_class.new(translated_feed) }

    let(:translated_feed) { instance_double('FeedTranslator') }

    before(:each) do
      allow(translated_feed).to receive(:request).and_return('http://example.com/feed')
    end

    describe "#body" do
      it "includes :request key" do
        expect(formatted_feed.body).to have_key(:request)
      end

      it "includes :desktop key" do
        expect(formatted_feed.body).to have_key(:desktop)
      end

      it "includes :ios key" do
        expect(formatted_feed.body).to have_key(:ios)
      end

      it "includes :android key" do
        expect(formatted_feed.body).to have_key(:android)
      end
    end

    describe "#body[:request]" do
      it "[:feed] = 'http://example.com/feed'" do 
        expect(formatted_feed.body[:request][:feed]).to eq("http://example.com/feed")
      end
    end

    describe "#body[:desktop]" do
      it "includes :default key" do
        expect(formatted_feed.body[:desktop]).to have_key(:default)
      end

      it "includes :rss key" do
        expect(formatted_feed.body[:desktop]).to have_key(:rss)
      end

      it "includes :itunes key" do
        expect(formatted_feed.body[:desktop]).to have_key(:itunes)
      end

      it "includes :apple_podcasts key" do
        expect(formatted_feed.body[:desktop]).to have_key(:apple_podcasts)
      end
    end
  end
end
