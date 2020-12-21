class Category < ApplicationRecord
  belongs_to :background
  
  validates :name, presence: true
end
