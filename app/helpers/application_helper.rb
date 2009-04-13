module ApplicationHelper
  include TagsHelper

  def current?(dst)
    dst = '/' + dst unless dst.index('/') == 0
    request.request_uri.index(dst) == 0 ? 'current' : nil
  end

  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, flash[msg.to_sym], :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end

  def user_html str
    Sanitize.clean(str, Sanitize::Config::BASIC).gsub("\n", "<br>\n")
  end

  # helpers related to the current logged-in user (if any)
  def logged_in?
    @current_user
  end

  def admin?
    logged_in? and @current_user.admin?
  end

  def is_current_user? user
    logged_in? and @current_user == user
  end
end
