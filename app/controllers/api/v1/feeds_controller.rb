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
        request: { feed: profile_params.fetch(:feed) },
        desktop: @feed.desktop,
        ios: @feed.ios,
        android: @feed.android
      }
    end

    def profile_params
      params
        .require(:data)
        .permit(:feed)
    end
  end
end
