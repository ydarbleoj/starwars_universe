module Api
  module V1
    class VehiclesController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = CheckCache.new(@query, 'Vehicle').page_info
        render json: response
      end

      def show
        response = Vehicle.where(vehicle_id: params[:vehicle_id]).first
        if response
          render json: response
        else
          response = CheckCache.new(request.path, 'Vehicle').record_info
          render json: response
        end
      end

      private
      def vehicle_params
        id = parse_url_id
        params.require(:vehicle).permit(
          :id, :vehicle_id, :name, :model, :vehicle_class, :manufacturer, :length,
          :cost_in_credits, :crew, :passengers, :max_atmosphering_speed,
          :cargo_capacity, :consumables, :created, :url, :edited, films: [],
          pilots: [])
      end

      def set_query
        @query = params['page'] ? '/vehicles/?page=' + params['page'].split('/')[0] : '/vehicles/?page=1'
      end
    end
  end
end