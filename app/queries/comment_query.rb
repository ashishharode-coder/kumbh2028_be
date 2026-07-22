class CommentQuery
  def initialize(id)
    @id = id
  end

  def call
    comment = Comment.active.find_by(id: @id)

    if comment
      ServiceResult.new(
        success: true,
        data: comment
      )
    else
      ServiceResult.new(
        success: false,
        message: "Comment not found."
      )
    end
  end

  private

  attr_reader :id
end