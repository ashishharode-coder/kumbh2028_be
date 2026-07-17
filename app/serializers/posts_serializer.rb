class PostsSerializer
  def self.render(posts)
    posts.map do |post|
      PostSerializer.render(post)
    end
  end
end