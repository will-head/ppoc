require 'feed_translator'

module Api::V1
  class FeedsController < ApiController

    def create
      @feed = FeedTranslator.new(profile_params.fetch(:feed))
      render json: @feed.body
    end

    protected

    def profile_params
      params
        .require(:data)
        .permit(:feed)
    end
  end
end
