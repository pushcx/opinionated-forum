module UsersHelper
  def shorten_username(str)
    # Remove http:// from users who haven't set their name
    str.gsub!(/^http:\/\/(.*)\/?/, '\1')
    # If str is some name-like thing ("John James Doe"), abbreviate to "John James D."
    str.gsub!(/(.+)(\W+)(\w)\w+$/, '\1\2\3.') if str.match(/(\w+)(\W+)(\w).*/)
    str = truncate(str, 12)
  end
end
