class Category < ApplicationRecord
    has_many :background_categories
    has_many :backgrounds, through: :background_categories
    validates_presence_of :name
    validates :name, length:{minimum:4,maximum:16}
end
