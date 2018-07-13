module Api
  module V1
    class PeopleController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = CheckCache.new(@query, 'Person').page_info
        render json: response
      end

      def show
        response = Person.where(person_id: params[:person_id]).first
        if response
          render json: response
        else
          response = CheckCache.new(request.path, 'Person').record_info
          render json: response
        end
      end

      private
      def person_params
        params.require(:person).permit(
          :id, :person_id, :name, :birth_year, :eye_color, :gender, :hair_color, :height, :mass,
          :skin_color, :homeworld, :url, :created, :edited, films: [], species: [], starships: [],
          vehicles: [])
      end

      def set_query
        @query = params['page'] ? '/people/?page=' + params['page'].split('/')[0] : '/people/?page=1'
      end
    end
  end
end