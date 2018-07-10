module Api
  module V1
    class FilmsController < ApplicationController
      before_action :set_query, only: [:index]

      def index
        response = StarWarsApi.new(@query).call.parsed_response
        render json: response
      end

      def show
        @film = Film.find(params[:id])
        render json: @film
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: 'record not found' }
      end

      def create
        film = Film.new(film_params)
        if film.save!
          render json: film
        else
          render json: { error: film.errors.messages }, status: :unprocessable_entity
        end
      end

      private
      def film_params
        id = parse_url_id
        params.require(:film).permit(
          :id, :title, :episode_id, :opening_crawl, :director, :producer,
          :release_date, :url, :created, :edited, species: [], starships: [],
          vehicles: [], characters: [], planets: []).tap do |obj|
          obj[:film_id] = id
        end
      end

      def parse_url_id
        p params
        /\d+/.match(params[:film][:url]).try(:[], 0).to_i
      end

      def set_query
        @query = params['page'] ? '/films/?page=' + params['page'].split('/')[0] : '/films'
      end
    end
  end
end