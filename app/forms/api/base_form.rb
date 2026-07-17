module Api
  class BaseForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    def attributes_hash
      attributes.compact_blank
    end
  end
end