module Api
  module V1
    class SpeciesController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = CheckCache.new(@query, 'Species').page_info
        render json: response
      end

      def show
        response = Species.where(species_id: params[:species_id]).first
        if response
          render json: response
        else
          resposne = CheckCache.new(request.path, 'Species').record_info
          render json: response
        end
      end

      private
      def species_params
        params.require(:species).permit(
          :id, :species_id, :name, :classification, :average_lifespan, :eye_colors,
          :hair_colors, :designation, :average_height, :skin_colors,
          :homeworld, :url, :language, :created, :edited, films: [],
          people: [])
      end

      def set_query
        @query = params['page'] ? '/species/?page=' + params['page'].split('/')[0] : '/species/?page=1'
      end
    end
  end
end