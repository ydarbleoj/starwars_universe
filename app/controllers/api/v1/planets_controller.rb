module Api
  module V1
    class PlanetsController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = StarWarsApi.new(@query).call.parsed_response
        render json: response
      end

      def show
        planet = Planet.find(params[:id])
        render json: planet
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: 'record not found' }
      end

      def create
        planet = Planet.new(planet_params)
        if planet.save!
          render json: planet
        else
          render json: { error: planet.errors.messages }, status: :unprocessable_entity
        end
      end

      private
      def planet_params
        id = parse_url_id
        params.require(:planet).permit(
          :id, :name, :diameter, :rotation_period, :orbital_period, :gravity,
          :population, :climate, :url, :surface_water, :terrain, :created, :edited, residents: [],
          films: []).tap do |obj|
          obj[:planet_id] = id
        end
      end

      def parse_url_id
        p params
        /\d+/.match(params[:planet][:url]).try(:[], 0).to_i
      end

      def set_query
        @query = params['page'] ? '/planets/?page=' + params['page'].split('/')[0] : '/planets'
      end
    end
  end
end