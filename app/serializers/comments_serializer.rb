class CommentsSerializer < ApplicationSerializer
  def self.render(comments, current_user: nil)
    CommentTreeSerializer.new(
      comments,
      current_user: current_user
    ).render
  end
end