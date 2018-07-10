module Api
  module V1
    class SpeciesController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = StarWarsApi.new(@query).call.parsed_response
        render json: response
      end

      def show
        species = Species.find(params[:id])
        render json: species
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: 'record not found' }
      end

      def create
        species = Species.new(species_params)
        if species.save!
          render json: species
        else
          render json: { error: species.errors.messages }, status: :unprocessable_entity
        end
      end

      private
      def species_params
        id = parse_url_id
        params.require(:species).permit(
          :id, :name, :classification, :average_lifespan, :eye_colors,
          :hair_colors, :designation, :average_height, :skin_colors,
          :homeworld, :url, :language, :created, :edited, films: [],
          people: []).tap do |obj|
          obj[:species_id] = id
        end
      end

      def parse_url_id
        p params
        /\d+/.match(params[:species][:url]).try(:[], 0).to_i
      end

      def set_query
        @query = params['page'] ? '/species/?page=' + params['page'].split('/')[0] : '/species/'
      end
    end
  end
end