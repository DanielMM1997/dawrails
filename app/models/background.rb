class Background < ApplicationRecord
    has_many :background_categories, dependent: :destroy
    has_many :categories, through: :background_categories
    has_many :likes, dependent: :destroy
    has_many :users, through: :likes
    belongs_to :author, class_name: :User, foreign_key: :author_id
    validates_presence_of :title, :path
    validates :title, length:{minimum:4,maximum:80}
end
