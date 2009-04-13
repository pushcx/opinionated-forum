module TopicsHelper
  def class_style_for_seen_topic(topic, user)
    return "read" unless user
    # A topic can be read because the user has "marked all topics read"
    return "read" if user.all_read_upto && user.all_read_upto > topic.posts.last.created_at
    # Or because he read the topic
    return "read" if viewing = topic.last_read_by(user) and viewing.seen >= topic.posts.last.created_at
    return "unread"
  end

  def posters_by_latest(posts)
    Hash[ *posts.collect { |p| [p.user, p.created_at] }.flatten ].sort_by { |user, at| at }
  end
end
