# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery # :secret => 'd252489c64a965e4db2ea656c6688140'
  layout 'application'
  before_filter :find_logged_in_user

  private

  def find_logged_in_user
    return true if session[:user_openid_url].blank? # not logged in

    @current_user = User.find_or_initialize_by_openid_url(:openid_url => session[:user_openid_url], :name => session[:user_openid_url])
    @current_user.save!
    true
  end

  def require_login
    logged_in?
  end

  # Cache different pages for Admin and Users
  def action_fragment_key(options)
    url_for(options).split('://').last
  end

end
