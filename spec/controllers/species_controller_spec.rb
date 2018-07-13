require 'rails_helper'

RSpec.describe Api::V1::SpeciesController, type: :controller do
  def response_body
    JSON.parse(response.body)
  end

  describe "GET #index" do
    include_examples "index example", 'species/?page=1'
  end

  describe "GET show" do
    it "created object should match api " do
      VCR.use_cassette('species 1') do
        obj = StarWarsApi.new('/species/1/').call.parsed_response
        species_id = /\d+/.match(obj['url']).try(:[], 0).to_i
        get :show, xhr: true, params: { species_id: 1 }

        obj = Species.create(obj.merge({ species_id: species_id }))

        new_obj = response_body
        expect(species_id).to eq(new_obj['species_id'])
        expect(obj['name']).to eq(new_obj['name'])
        expect(obj['classification']).to eq(new_obj['classification'])
        expect(obj['designation']).to eq(new_obj['designation'])
        expect(obj['average_height']).to eq(new_obj['average_height'])
        expect(obj['average_lifespan']).to eq(new_obj['average_lifespan'])
        expect(obj['eye_colors']).to eq(new_obj['eye_colors'])
        expect(obj['hair_colors']).to eq(new_obj['hair_colors'])
        expect(obj['skin_colors']).to eq(new_obj['skin_colors'])
        expect(obj['language']).to eq(new_obj['language'])
        expect(obj['homeworld']).to eq(new_obj['homeworld'])
        expect(obj['people']).to eq(new_obj['people'])
        expect(obj['films']).to eq(new_obj['films'])
        expect(obj['url']).to eq(new_obj['url'])
        expect(obj['created']).to eq(new_obj['created'])
        expect(obj['edited']).to eq(new_obj['edited'])
        expect(obj['name']).not_to eq('JimZ')
        expect(new_obj['id']).to_not eq(0)
        expect(new_obj['id']).to_not be_nil
      end
    end
  end
end