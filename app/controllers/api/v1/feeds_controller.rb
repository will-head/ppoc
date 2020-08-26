require 'feed_translator'

module Api::V1
  class FeedsController < ApiController

    def create
      @feed = FeedTranslator.new(profile_params.fetch(:feed))
      render json: body
    end

    protected

    def body
      {
        request: {
          feed:  profile_params.fetch(:feed)
        },
        desktop: {
          rss: {
            feed_title: "RSS",
            feed_url: @feed.rss
          },
          itunes: {
            feed_title: "iTunes",
            feed_url: "itpc://example.com/feed"
          },
          apple_podcasts: {
            feed_title: "Apple Podcasts",
            feed_url: "podcast://example.com/feed"
          }
        },
        ios: {},
        android: {}
      }
    end

    def profile_params
      params
        .require(:data)
        .permit(:feed)
    end
  end
end
