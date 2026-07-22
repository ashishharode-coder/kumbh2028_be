class PostsSerializer
  def self.render(posts, user: nil)
    posts.map do |post|
      PostSerializer.render(post, user: user)
    end
  end
end