class DashboardController < ApplicationController
  before_action :authenticate_user

  def index
  	client = HTTPClient.new
  	extheader = {'X-GLB-Token' => '19ef4ab5c7c76e0e6a4485aeb681e56ea4e474347337a36734f66524546436c4e786663716c764a6a6b5f58346d63526466433072726b324736505a6e6f69706b2d6635376e792d4834586d627a712d434c614c3866314770635f314b792d2d614b2d623130773d3d3a303a7269636172646f70756c6963655f323031315f35'}
  	url = 'https://api.cartolafc.globo.com/auth/liga/openbar-liga-espetaculosa'
	@liga = client.get_content(url, '', extheader)
  end

end