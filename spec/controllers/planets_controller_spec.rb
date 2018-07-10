require 'rails_helper'

RSpec.describe Api::V1::PlanetsController, type: :controller do
  def response_body
    JSON.parse(response.body)
  end

  describe "GET #index" do
    include_examples "index example", 'planets all', '/planets/'
  end

  describe "POST create" do
    it "created object should match api " do
      VCR.use_cassette('/planets/1/') do
        obj = StarWarsApi.new('/planets/1/').call.parsed_response
        post :create, xhr: true, params: { planet: obj }

        new_obj = response_body
        planet_id = /\d+/.match(obj['url']).try(:[], 0).to_i
        expect(obj['name']).to eq(new_obj['name'])
        expect(obj['diameter']).to eq(new_obj['diameter'])
        expect(obj['rotation_period']).to eq(new_obj['rotation_period'])
        expect(obj['orbital_period']).to eq(new_obj['orbital_period'])
        expect(obj['gravity']).to eq(new_obj['gravity'])
        expect(obj['population']).to eq(new_obj['population'])
        expect(obj['climate']).to eq(new_obj['climate'])
        expect(obj['terrain']).to eq(new_obj['terrain'])
        expect(obj['surface_water']).to eq(new_obj['surface_water'])
        expect(obj['residents']).to eq(new_obj['residents'])
        expect(obj['films']).to eq(new_obj['films'])
        expect(obj['created']).to eq(new_obj['created'])
        expect(obj['edited']).to eq(new_obj['edited'])
        expect(obj['url']).to eq(new_obj['url'])
        expect(planet_id).to eq(new_obj['planet_id'])
        expect(obj['name']).not_to eq('Jim')
        expect(new_obj['id']).to_not eq(0)
        expect(new_obj['id']).to_not be_nil
      end
    end
  end
end