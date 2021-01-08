class BackgroundSerializer < ActiveModel::Serializer
  attributes :id, :title, :path, :tags

  # has_many :categories
end
