require 'rails_helper'

RSpec.describe FeedTranslationsController, type: :controller do

  describe "GET #feeds" do
    it "returns http success" do
      get :feeds
      expect(response).to have_http_status(:success)
    end
  end

end
