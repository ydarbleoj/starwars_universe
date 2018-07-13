require 'rails_helper'

RSpec.describe Api::V1::FilmsController, type: :controller do
  def response_body
    JSON.parse(response.body)
  end

  describe "GET #index" do
    include_examples "index example", 'films/?page=1'
  end

  describe "GET show" do
    it "created object should match api " do
      VCR.use_cassette('films 1') do
        obj = StarWarsApi.new('/films/1/').call.parsed_response
        film_id = /\d+/.match(obj['url']).try(:[], 0).to_i
        get :show, xhr: true, params: { film_id: 1 }

        obj = Film.create(obj.merge({ film_id: film_id }))

        new_obj = response_body
        expect(obj['title']).to eq(new_obj['title'])
        expect(obj['episode_id']).to eq(new_obj['episode_id'])
        expect(obj['opening_crawl']).to eq(new_obj['opening_crawl'])
        expect(obj['director']).to eq(new_obj['director'])
        expect(obj['producer']).to eq(new_obj['producer'])
        expect(obj['release_date']).to eq(new_obj['release_date'])
        expect(obj['species']).to eq(new_obj['species'])
        expect(obj['starships']).to eq(new_obj['starships'])
        expect(obj['vehicles']).to eq(new_obj['vehicles'])
        expect(obj['characters']).to eq(new_obj['characters'])
        expect(obj['planets']).to eq(new_obj['planets'])
        expect(obj['url']).to eq(new_obj['url'])
        expect(obj['created']).to eq(new_obj['created'])
        expect(obj['edited']).to eq(new_obj['edited'])
        expect(film_id).to eq(new_obj['film_id'])
        expect(obj['title']).not_to eq('Jim')
        expect(new_obj['id']).to_not eq(0)
        expect(new_obj['id']).to_not be_nil
      end
    end
  end
end