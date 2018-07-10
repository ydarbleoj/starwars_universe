require 'rails_helper'

RSpec.describe Api::V1::StarshipsController, type: :controller do
  def response_body
    JSON.parse(response.body)
  end

  describe "GET #index" do
    include_examples "index example", 'starships all', '/starships/'
  end

  describe "POST create" do
    it "created object should match api " do
      VCR.use_cassette('/starships/2/') do
        obj = StarWarsApi.new('/starships/2/').call.parsed_response
        post :create, xhr: true, params: { starship: obj }

        new_obj = response_body
        starship_id = /\d+/.match(obj['url']).try(:[], 0).to_i
        expect(obj['model']).to eq(new_obj['model'])
        expect(obj['starship_class']).to eq(new_obj['starship_class'])
        expect(obj['manufacturer']).to eq(new_obj['manufacturer'])
        expect(obj['cost_in_credits']).to eq(new_obj['cost_in_credits'])
        expect(obj['length']).to eq(new_obj['length'])
        expect(obj['crew']).to eq(new_obj['crew'])
        expect(obj['passengers']).to eq(new_obj['passengers'])
        expect(obj['max_atmosphering_speed']).to eq(new_obj['max_atmosphering_speed'])
        expect(obj['hyperdrive_rating']).to eq(new_obj['hyperdrive_rating'])
        expect(obj['MGLT']).to eq(new_obj['mglt'])
        expect(obj['cargo_capacity']).to eq(new_obj['cargo_capacity'])
        expect(obj['consumables']).to eq(new_obj['consumables'])
        expect(obj['pilots']).to eq(new_obj['pilots'])
        expect(obj['films']).to eq(new_obj['films'])
        expect(obj['created']).to eq(new_obj['created'])
        expect(obj['edited']).to eq(new_obj['edited'])
        expect(obj['url']).to eq(new_obj['url'])
        expect(starship_id).to eq(new_obj['starship_id'])
        expect(new_obj['id']).to_not eq(0)
        expect(new_obj['id']).to_not be_nil
      end
    end
  end
end