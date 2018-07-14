module Api
  module V1
    class PlanetsController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = CheckCache.new(@query, 'Planet').page_info
        render json: response
      end

      def show
        response = Planet.where(planet_id: params[:planet_id]).first
        if response
          response = response.show_attributes
          render json: response
        else
          response = CheckCache.new(request.path, 'Planet').record_info
          render json: response
        end
      end

      private
      def planet_params
        params.require(:planet).permit(
          :id, :planet_id, :name, :diameter, :rotation_period, :orbital_period, :gravity,
          :population, :climate, :url, :surface_water, :terrain, :created, :edited,
          residents: [], films: [])
      end

      def set_query
        @query = params['page'] ? '/planets/?page=' + params['page'].split('/')[0] : '/planets/?page=1'
      end
    end
  end
end