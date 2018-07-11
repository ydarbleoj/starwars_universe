module Api
  module V1
    class PeopleController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = CheckCache.new(@query, 'Person').execute
        render json: response
      end

      def show
        @person = Person.find(params[:id])
        render json: @person
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: 'record not found' }
      end

      private
      def person_params
        id = parse_url_id
        params.require(:person).permit(
          :id, :name, :birth_year, :eye_color, :gender, :hair_color, :height, :mass,
          :skin_color, :homeworld, :url, :created, :edited, films: [], species: [], starships: [],
          vehicles: []).tap do |obj|
          obj[:person_id] = id
        end
      end

      def parse_url_id
        /\d+/.match(params[:person][:url]).try(:[], 0).to_i
      end

      def set_query
        @query = params['page'] ? '/people/?page=' + params['page'].split('/')[0] : '/people/?page=1'
      end
    end
  end
end