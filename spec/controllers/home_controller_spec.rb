require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "has an http response code of 200" do
      obj = VCR.use_cassette('starwars list') do
        get :index, xhr: true
        expect(response.code).to eq('200')
      end
    end
  end
end