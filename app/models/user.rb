class User < ApplicationRecord
  has_many :backgrounds, foreign_key: :author_id
  has_many :likes
  validates_presence_of :nickname, :email, :password, :type
  validates :password, length:{minimum:8,maximum:32}
  validates :nickname, length:{minimum:5,maximum:20}
  validates :email, length:{minimum:6,maximum:32}
end
