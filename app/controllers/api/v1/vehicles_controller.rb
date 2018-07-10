module Api
  module V1
    class VehiclesController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = StarWarsApi.new(@query).call.parsed_response
        render json: response
      end

      def show
        vehicle = Vehicle.find(params[:id])
        render json: vehicle
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: 'record not found' }
      end

      def create
        vehicle = Vehicle.new(vehicle_params)
        if vehicle.save!
          render json: vehicle
        else
          render json: { error: vehicle.errors.messages }, status: :unprocessable_entity
        end
      end

      private
      def vehicle_params
        id = parse_url_id
        params.require(:vehicle).permit(
          :id, :vehicle_id, :name, :model, :vehicle_class, :manufacturer, :length,
          :cost_in_credits, :crew, :passengers, :max_atmosphering_speed,
          :cargo_capacity, :consumables, :created, :url, :edited, films: [],
          pilots: []).tap do |obj|
          obj[:vehicle_id] = id
        end
      end

      def parse_url_id
        /\d+/.match(params[:vehicle][:url]).try(:[], 0).to_i
      end

      def set_query
        @query = params['page'] ? '/vehicles/?page=' + params['page'].split('/')[0] : '/vehicles'
      end
    end
  end
end