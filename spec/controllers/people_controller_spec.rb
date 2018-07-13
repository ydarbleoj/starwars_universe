require 'rails_helper'

RSpec.describe Api::V1::PeopleController, type: :controller do
  def response_body
    JSON.parse(response.body)
  end

  describe "GET #index" do
    include_examples "index example", 'people/?page=1'
  end

  describe "GET show" do
    it "created object should match api " do
      VCR.use_cassette('people 1') do
        obj = StarWarsApi.new('/people/1/').call.parsed_response
        person_id = /\d+/.match(obj['url']).try(:[], 0).to_i
        get :show, xhr: true, params: { person_id: 1 }

        obj = Person.create(obj.merge({ person_id: person_id }))

        new_obj = response_body
        expect(obj['name']).to eq(new_obj['name'])
        expect(obj['birth_year']).to eq(new_obj['birth_year'])
        expect(obj['eye_color']).to eq(new_obj['eye_color'])
        expect(obj['gender']).to eq(new_obj['gender'])
        expect(obj['hair_color']).to eq(new_obj['hair_color'])
        expect(obj['height']).to eq(new_obj['height'])
        expect(obj['mass']).to eq(new_obj['mass'])
        expect(obj['skin_color']).to eq(new_obj['skin_color'])
        expect(obj['homeworld']).to eq(new_obj['homeworld'])
        expect(obj['url']).to eq(new_obj['url'])
        expect(obj['created']).to eq(new_obj['created'])
        expect(obj['edited']).to eq(new_obj['edited'])
        expect(obj['films']).to eq(new_obj['films'])
        expect(obj['species']).to eq(new_obj['species'])
        expect(obj['starships']).to eq(new_obj['starships'])
        expect(obj['vehicles']).to eq(new_obj['vehicles'])
        expect(person_id).to eq(new_obj['person_id'])
        expect(obj['name']).not_to eq('Jim')
        expect(new_obj['id']).to_not eq(0)
        expect(new_obj['id']).to_not be_nil
      end
    end
  end
end