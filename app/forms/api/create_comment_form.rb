module Api
  class CreateCommentForm < BaseForm
    attribute :content, :string
    attribute :parent_id, :integer

    validates :content, presence: true
  end
end