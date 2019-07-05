class ApplicationController < ActionController::Base

  respond_to :json
  #protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery with: :null_session

  layout :layout_by_resource



  def authorize_by_jwt
    token = request.headers["HTTP_AUTHORIZATION"].gsub("Bearer ", "")
    @current_agent = Warden::JWTAuth::UserDecoder.new.call(token, :agent, nil)
  end

  def access_required
    render :json => {
      :response => 'Unable to authenticate'
    } ,:status => 401 and return if @current_agent.blank?
  end


  def render_empty
    render html: '', :layout => 'application'
  end

  def user_session
    render json: { current_user: {
      email: current_user.email }
    }
  end

  def catch_all
    render_empty
  end

  private

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

end
