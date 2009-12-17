# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except => :login

  layout "store"
  
#  session :session_key => '_depot_session_id'
  
  helper :all # include all helpers, all the time
  protect_from_forgery :secret => '8c3e099237e6366fd2f5366e9c430e79' # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password 
  
protected
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in"
      redirect_to :controller => :admin, :action => :login
    end
  end
end
