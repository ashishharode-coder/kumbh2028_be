class CommentTreeSerializer < ApplicationSerializer
  def initialize(comments, current_user:)
    @comments = comments
    @current_user = current_user
  end

  def render
    grouped = comments.group_by(&:parent_id)

    build_tree(grouped[nil] || [], grouped)
  end

  private

  attr_reader :comments, :current_user

  def build_tree(nodes, grouped)
    nodes.map do |comment|
      {
        id: comment.id,
        content: comment.content,
        parent_id: comment.parent_id,
        user: UserSerializer.render(comment.user),
        is_owner: comment.user_id == current_user&.id,
        created_at: format_datetime(comment.created_at),
        updated_at: format_datetime(comment.updated_at),
        replies: build_tree(grouped[comment.id] || [], grouped)
      }
    end
  end

  def format_datetime(datetime)
    datetime&.iso8601
  end
end