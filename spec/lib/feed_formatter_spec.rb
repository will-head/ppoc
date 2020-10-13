require 'rails_helper'
require 'feed_formatter'

describe FeedFormatter do

  context "with translated feed: http://example.com/feed" do 
    subject(:formatted_feed) { described_class.new(translated_feed) }

    let(:translated_feed) { instance_double('FeedTranslator') }

    before(:each) do
      allow(translated_feed).to receive(:valid_request?).and_return('http://example.com/feed')
      allow(translated_feed).to receive(:request).and_return('http://example.com/feed')
      allow(translated_feed).to receive(:feed).and_return('feed://example.com/feed')
      allow(translated_feed).to receive(:http).and_return('http://example.com/feed')
      allow(translated_feed).to receive(:itpc).and_return('itpc://example.com/feed')
      allow(translated_feed).to receive(:podcast).and_return('podcast://example.com/feed')
      allow(translated_feed).to receive(:overcast).and_return('overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed')
      allow(translated_feed).to receive(:castro).and_return('castro://subscribe/example.com/feed')
      allow(translated_feed).to receive(:pktc).and_return('pktc://subscribe/example.com/feed')
      allow(translated_feed).to receive(:downcast).and_return('downcast://example.com/feed')
      allow(translated_feed).to receive(:pcast).and_return('pcast://example.com/feed')
    end

    describe "#body" do
      it "includes :status key" do
        expect(formatted_feed.body).to have_key(:status)
      end

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

    describe "#body[:status]" do
      it "returns 200" do
        expect(formatted_feed.body[:status]).to eq(200)
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

    describe "#body[:desktop][:itunes]" do
      it "[:feed_title] = 'iTunes'" do
        expect(formatted_feed.body[:desktop][:itunes][:feed_title]).to eq("iTunes")
      end

      it "[:feed_url] = 'itpc://example.com/feed'" do
        expect(formatted_feed.body[:desktop][:itunes][:feed_url]).to eq("itpc://example.com/feed")
      end
    end

    describe "#body[:desktop][:apple_podcasts]" do
      it "[:feed_title] = 'Apple Podcasts'" do
        expect(formatted_feed.body[:desktop][:apple_podcasts][:feed_title]).to eq("Apple Podcasts")
      end

      it "[:feed_url] = 'podcast://example.com/feed'" do
        expect(formatted_feed.body[:desktop][:apple_podcasts][:feed_url]).to eq("podcast://example.com/feed")
      end
    end

    describe "#body[:ios]" do
      it "includes :default key" do
        expect(formatted_feed.body[:ios]).to have_key(:default)
      end

      it "includes :apple_podcasts key" do
        expect(formatted_feed.body[:ios]).to have_key(:apple_podcasts)
      end

      it "includes :overcast key" do
        expect(formatted_feed.body[:ios]).to have_key(:overcast)
      end

      it "includes :castro key" do
        expect(formatted_feed.body[:ios]).to have_key(:castro)
      end

      it "includes :pocket_casts key" do
        expect(formatted_feed.body[:ios]).to have_key(:pocket_casts)
      end

      it "includes :downcast key" do
        expect(formatted_feed.body[:ios]).to have_key(:downcast)
      end
    end

    describe "#body[:ios][:default]" do
      it "[:feed_title] = 'Default'" do
        expect(formatted_feed.body[:ios][:default][:feed_title]).to eq("Default")
      end

      it "[:feed_url] = 'feed://example.com/feed'" do
        expect(formatted_feed.body[:ios][:default][:feed_url]).to eq("feed://example.com/feed")
      end
    end

    describe "#body[:ios][:apple_podcasts]" do
      it "[:feed_title] = 'Apple Podcasts'" do
        expect(formatted_feed.body[:ios][:apple_podcasts][:feed_title]).to eq("Apple Podcasts")
      end

      it "[:feed_url] = 'podcast://example.com/feed'" do
        expect(formatted_feed.body[:ios][:apple_podcasts][:feed_url]).to eq("podcast://example.com/feed")
      end
    end

    describe "#body[:ios][:overcast]" do
      it "[:feed_title] = 'Overcast'" do
        expect(formatted_feed.body[:ios][:overcast][:feed_title]).to eq("Overcast")
      end

      it "[:feed_url] = 'overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed'" do
        expect(formatted_feed.body[:ios][:overcast][:feed_url]).to eq("overcast://x-callback-url/add?url=http%3A%2F%2Fexample.com%2Ffeed")
      end
    end

    describe "#body[:ios][:castro]" do
      it "[:feed_title] = 'Castro'" do
        expect(formatted_feed.body[:ios][:castro][:feed_title]).to eq("Castro")
      end

      it "[:feed_url] = 'castro://subscribe/example.com/feed'" do
        expect(formatted_feed.body[:ios][:castro][:feed_url]).to eq("castro://subscribe/example.com/feed")
      end
    end

    describe "#body[:ios][:pocket_casts]" do
      it "[:feed_title] = 'Pocket Casts'" do
        expect(formatted_feed.body[:ios][:pocket_casts][:feed_title]).to eq("Pocket Casts")
      end

      it "[:feed_url] = 'pktc://subscribe/example.com/feed'" do
        expect(formatted_feed.body[:ios][:pocket_casts][:feed_url]).to eq("pktc://subscribe/example.com/feed")
      end
    end

    describe "#body[:ios][:downcast]" do
      it "[:feed_title] = 'Downcast'" do
        expect(formatted_feed.body[:ios][:downcast][:feed_title]).to eq("Downcast")
      end

      it "[:feed_url] = 'downcast://example.com/feed'" do
        expect(formatted_feed.body[:ios][:downcast][:feed_url]).to eq("downcast://example.com/feed")
      end
    end

    describe "#body[:android]" do
      it "includes :default key" do
        expect(formatted_feed.body[:android]).to have_key(:default)
      end
    end

    describe "#body[:android][:default]" do
      it "[:feed_title] = 'Default'" do
        expect(formatted_feed.body[:android][:default][:feed_title]).to eq("Default")
      end

      it "[:feed_url] = 'pcast://example.com/feed'" do
        expect(formatted_feed.body[:android][:default][:feed_url]).to eq("pcast://example.com/feed")
      end
    end
  end

  context "with invalid translated feed: 'not valid'" do 
    subject(:formatted_feed) { described_class.new(translated_feed) }

    let(:translated_feed) { instance_double('FeedTranslator') }

    before(:each) do
      allow(translated_feed).to receive(:valid_request?).and_return(false)
      allow(translated_feed).to receive(:request).and_return('http://example.com/feed')
    end

    describe "#body[:status]" do
      it "returns 422" do
        expect(formatted_feed.body[:status]).to eq(422)
      end
    end
  end
end
