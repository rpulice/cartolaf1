class AlyssonsController < ApplicationController
	require 'json'
  before_action :authenticate_user

  def index
		@teams = Team.all
  	client = HTTPClient.new
		@status = client.get_content('https://api.cartolafc.globo.com/mercado/status')
		@alysson = ActiveSupport::JSON.decode(Alysson.first.pontos)
  end
end