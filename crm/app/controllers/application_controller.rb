# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authenticate
  helper :all
  
  protect_from_forgery
  before_filter :require_user
  filter_parameter_logging :password
  helper_method :current_user

end
