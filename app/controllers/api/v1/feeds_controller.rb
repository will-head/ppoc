require 'feed_translator'
require 'feed_formatter'

module Api::V1
  class FeedsController < ApiController

    def create
      @translated_feed = FeedTranslator.new(profile_params.fetch(:feed))
      if @translated_feed.valid_request?
        @formatted_feed = FeedFormatter.new(@translated_feed)
        render json: @formatted_feed.body
      else
        render json: { }, status: 422
      end
    end

    protected

    def profile_params
      params
        .require(:data)
        .permit(:feed)
    end
  end
end
