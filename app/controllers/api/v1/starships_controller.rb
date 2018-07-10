module Api
  module V1
    class StarshipsController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = StarWarsApi.new(@query).call.parsed_response
        render json: response
      end

      def show
        starship = Starship.find(params[:id])
        render json: starship
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: 'record not found' }
      end

      def create
        starship = Starship.new(planet_params)
        if starship.save!
          render json: starship
        else
          render json: { error: starship.errors.messages }, status: :unprocessable_entity
        end
      end

      private
      def planet_params
        id = parse_url_id
        mglt = params[:starship][:MGLT]
        params.require(:starship).permit(
          :id, :starship_id, :model, :starship_class, :manufacturer, :length,
          :cost_in_credits, :crew, :url, :passengers, :max_atmosphering_speed, :hyperdrive_rating,
          :cargo_capacity, :consumables, :created, :edited, films: [],
          pilots: []).tap do |obj|
            obj[:starship_id] = id
            obj[:mglt] = mglt
        end
      end

      def parse_url_id
        /\d+/.match(params[:starship][:url]).try(:[], 0).to_i
      end

      def set_query
        @query = params['page'] ? '/starships/?page=' + params['page'].split('/')[0] : '/starships'
      end
    end
  end
end