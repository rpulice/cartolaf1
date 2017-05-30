class ParcialsController < ApplicationController
  before_action :authenticate_user

  def index
	@liga = liga
  	client = HTTPClient.new
	@status = client.get_content('https://api.cartolafc.globo.com/mercado/status')
    cartola = ActiveSupport::JSON.decode(@status)
    if cartola['status_mercado'] === 1
      redirect_to error_parcial_path
    end
  end

end