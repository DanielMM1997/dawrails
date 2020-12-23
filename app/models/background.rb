class Background < ApplicationRecord
  has_and_belongs_to_many :category
  belongs_to :user
  has_many :likes
  validates_presence_of :title, :path
  validates :title, length:{minimum:4,maximum:16}
end
