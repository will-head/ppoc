require 'feed_translator'

module Api::V1
  class FeedsController < ApiController

    def create
      @translated_feed = FeedTranslator.new(profile_params.fetch(:feed))
      render json: @translated_feed.body
    end

    protected

    def profile_params
      params
        .require(:data)
        .permit(:feed)
    end
  end
end
