module Api
  module V1
    class FeedsController < ApplicationController
      def create
        render json: body
      end

      protected

      def body
        {
          request: {
            feed:  profile_params.fetch(:feed)
          }
        }
      end

      def profile_params
        params
          .require(:data)
          .permit(:feed)
      end
    end
  end
end
