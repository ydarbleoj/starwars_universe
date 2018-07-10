require 'rails_helper'

RSpec.describe Api::V1::VehiclesController, type: :controller do
  def response_body
    JSON.parse(response.body)
  end

  describe "GET #index" do
    include_examples "index example", 'vehicles all', '/vehicles/'
  end

  describe "POST create" do
    it "created object should match api " do
      VCR.use_cassette('/vehicles/6/') do
        obj = StarWarsApi.new('/vehicles/6/').call.parsed_response
        post :create, xhr: true, params: { vehicle: obj }

        new_obj = response_body
        vehicle_id = /\d+/.match(obj['url']).try(:[], 0).to_i
        expect(obj['name']).to eq(new_obj['name'])
        expect(obj['model']).to eq(new_obj['model'])
        expect(obj['vehicle_class']).to eq(new_obj['vehicle_class'])
        expect(obj['manufacturer']).to eq(new_obj['manufacturer'])
        expect(obj['length']).to eq(new_obj['length'])
        expect(obj['cost_in_credits']).to eq(new_obj['cost_in_credits'])
        expect(obj['crew']).to eq(new_obj['crew'])
        expect(obj['passengers']).to eq(new_obj['passengers'])
        expect(obj['max_atmosphering_speed']).to eq(new_obj['max_atmosphering_speed'])
        expect(obj['pilots']).to eq(new_obj['pilots'])
        expect(obj['films']).to eq(new_obj['films'])
        expect(obj['created']).to eq(new_obj['created'])
        expect(obj['edited']).to eq(new_obj['edited'])
        expect(obj['url']).to eq(new_obj['url'])
        expect(vehicle_id).to eq(new_obj['vehicle_id'])
        expect(obj['name']).not_to eq('Jim')
        expect(new_obj['id']).to_not eq(0)
        expect(new_obj['id']).to_not be_nil
      end
    end
  end
end