module Authenticate
  protected
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def require_user
    unless current_user
      respond_to do |format|
        format.html do
          store_location
          flash[:notice] = t("MustLogged")
          redirect_to new_user_session_url
        end
        format.any(:xml, :json, :rss) do
          authenticate_or_request_with_http_basic do |username, password|
            @user_session = UserSession.new(:login => username, :password => password)
            @user_session.save
          end
        end
      end
    end
  end
 
  def redirect_back_or_default(default)
    logger.info { session[:return_to] }
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end