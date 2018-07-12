module Api
  module V1
    class FilmsController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = CheckCache.new(@query, 'Film').page_info
        render json: response
      end

      def show
        response = Film.where(film_id: params[:film_id]).first
        if response
          render json: response
        else
          resposne = CheckCache.new(request.path, 'Film').record_info
          render json: response
        end
      end

      private
      def film_params
        params.require(:film).permit(
          :id, :film_id, :title, :episode_id, :opening_crawl, :director, :producer,
          :release_date, :url, :created, :edited, species: [], starships: [],
          vehicles: [], characters: [], planets: [])
      end

      def set_query
        @query = params['page'] ? '/films/?page=' + params['page'].split('/')[0] : '/films/?page=1'
      end
    end
  end
end