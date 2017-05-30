module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def authenticate_user
    unless logged_in?
      flash[:danger] = "Por favor realize o login."
      redirect_to login_url
    end
  end

  def liga
    client = HTTPClient.new
    extheader = {'X-GLB-Token' => '19ef4ab5c7c76e0e6a4485aeb681e56ea4e474347337a36734f66524546436c4e786663716c764a6a6b5f58346d63526466433072726b324736505a6e6f69706b2d6635376e792d4834586d627a712d434c614c3866314770635f314b792d2d614b2d623130773d3d3a303a7269636172646f70756c6963655f323031315f35'}
    url = 'https://api.cartolafc.globo.com/auth/liga/openbar-liga-espetaculosa'
    @liga = client.get_content(url, '', extheader)
  end
end
