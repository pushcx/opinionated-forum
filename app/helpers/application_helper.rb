module ApplicationHelper
  include TagsHelper
  
  def current?(dst)
    dst = '/' + dst unless dst.index('/') == 0
    request.request_uri.index(dst) == 0 ? 'current' : nil
  end

  def user_html str
    Sanitize.clean(str, Sanitize::Config::BASIC).gsub("\n", "<br>\n")
  end
end
