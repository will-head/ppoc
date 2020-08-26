module Api::V1
  class FeedsController < ApiController
    def create
      render json: body
    end

    protected

    def body
      {
        request: {
          feed:  profile_params.fetch(:feed)
        },
        desktop: {},
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
