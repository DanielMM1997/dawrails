class Category < ApplicationRecord
    has_and_belongs_to_many :background
    validates_presence_of :name
    validates :name, length:{minimum:4,maximum:16}
end
