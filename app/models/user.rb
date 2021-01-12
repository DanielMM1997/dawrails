class User < ApplicationRecord
  require 'digest'

  self.inheritance_column = nil
  has_many :backgrounds, foreign_key: :author_id
  has_many :likes
  has_many :backgrounds, through: :likes
  validates_presence_of :nickname, :email, :password, :type
  validates :password, length:{minimum:8,maximum:32}
  validates :nickname, length:{minimum:5,maximum:20}
  validates :email, length:{minimum:6,maximum:32}

  before_create -> {self.password = Digest::SHA256.new << self.password }
end
