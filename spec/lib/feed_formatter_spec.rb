require 'rails_helper'
require 'feed_formatter'

describe FeedFormatter do

  context "with translated feed: http://example.com/feed" do 
    subject(:formatted_feed) { described_class.new(translated_feed) }

    let(:translated_feed) { instance_double('FeedTranslator') }

    before(:each) do
      allow(translated_feed).to receive(:request).and_return('http://example.com/feed')
      allow(translated_feed).to receive(:feed).and_return('feed://example.com/feed')
      allow(translated_feed).to receive(:http).and_return('http://example.com/feed')
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

    describe "#body[:desktop][:default]" do
      it "[:feed_title] = 'Default'" do
        expect(formatted_feed.body[:desktop][:default][:feed_title]).to eq("Default")
      end

      it "[:feed_url] = 'feed://example.com/feed'" do
        expect(formatted_feed.body[:desktop][:default][:feed_url]).to eq("feed://example.com/feed")
      end
    end

    describe "#body[:desktop][:rss]" do
      it "[:feed_title] = 'RSS'" do
        expect(formatted_feed.body[:desktop][:rss][:feed_title]).to eq("RSS")
      end

      it "[:feed_url] = 'http://example.com/feed'" do
        expect(formatted_feed.body[:desktop][:rss][:feed_url]).to eq("http://example.com/feed")
      end
    end
  end
end
