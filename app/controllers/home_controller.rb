class HomeController < ApplicationController

  def index
    @universe = StarWarsApi.new('').call.parsed_response
    respond_with(@universe)
  end
end