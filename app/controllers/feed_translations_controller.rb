class FeedTranslationsController < ApplicationController
  def feeds
    render json: response_body
  end

  protected

  def calculated_age
    # AgeCalculator.new(profile_params.fetch(:birthdate)).get_age!
    30
  end

  def response_body
    {
      request: {
        feed:  profile_params.fetch(:feed)
      },
      itunes: calculated_age
    }
  end

  def profile_params
    params
      .require(:data)
      .permit(:feed)
  end
end
