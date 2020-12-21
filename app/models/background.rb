class Background < ApplicationRecord
  has_many :categories
  has_many :tags

  validates :title, presence: true
  validates :url, presence: true
  validates :tags, presence: true
  validates :categories, presence: true

  # validate_presence_of :title, :url, :tags, :categories
end
