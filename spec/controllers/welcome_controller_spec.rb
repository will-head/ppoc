require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "#index" do 
    it "redirects_to https://podcastplayerofchoice.com" do
      expect(get :index).to redirect_to("https://podcastplayerofchoice.com")
    end
  end
end
