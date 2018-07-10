require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    include_examples 'index example', 'starwars list', '/'
  end
end