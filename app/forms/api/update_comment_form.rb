module Api
  class UpdateCommentForm < BaseForm
    attribute :content, :string

    validates :content, presence: true
  end
end