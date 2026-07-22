class CommentSerializer < ApplicationSerializer
  def self.render(comment, current_user: nil)
    {
      id: comment.id,
      content: comment.content,
      parent_id: comment.parent_id,
      user: UserSerializer.render(comment.user),
      is_owner: current_user.present? && comment.user_id == current_user.id,
      created_at: format_datetime(comment.created_at),
      updated_at: format_datetime(comment.updated_at)
    }
  end
end