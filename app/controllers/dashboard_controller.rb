class DashboardController < ApplicationController
  before_action :authenticate_user

  def index
		@liga = liga
  	client = HTTPClient.new
		@status = client.get_content('https://api.cartolafc.globo.com/mercado/status')
  end

end