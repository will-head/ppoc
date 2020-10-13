require 'rails_helper'
require 'feed_formatter'

describe FeedFormatter do

  context "with translated feed" do 
    subject(:formatted_feed) { described_class.new(translated_feed) }

    let(:translated_feed) { instance_double('FeedTranslator') }

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
  end
end
