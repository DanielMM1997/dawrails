class BackgroundSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :tag, :category

  has_many :categories
  has_many :tags
end
