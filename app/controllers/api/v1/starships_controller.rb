module Api
  module V1
    class StarshipsController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = CheckCache.new(@query, 'Starship').page_info
        render json: response
      end

      def show
        response = Starship.where(starship_id: params[:starship_id]).first
        if response
          render json: response
        else
          resposne = CheckCache.new(request.path, 'Starship').record_info
          render json: response
        end
      end

      private
      def starship_params
        params.require(:starship).permit(
          :id, :starship_id, :model, :starship_class, :manufacturer, :length, :mglt,
          :cost_in_credits, :crew, :url, :passengers, :max_atmosphering_speed, :hyperdrive_rating,
          :cargo_capacity, :consumables, :created, :edited, films: [],
          pilots: [])
      end

      def set_query
        @query = params['page'] ? '/starships/?page=' + params['page'].split('/')[0] : '/starships/?page=1'
      end
    end
  end
end