class User < ApplicationRecord
  require 'digest'

  REGEX_PASSWORD = /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}/
  REGEX_EMAIL = URI::MailTo::EMAIL_REGEXP

  self.inheritance_column = nil
  has_many :own_backgrounds, foreign_key: :author_id, class_name: "Background", dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :backgrounds, through: :likes
  validates_presence_of :nickname, :email, :password, :type
  validates :password, length:{minimum:8,maximum:32}, format: { with: REGEX_PASSWORD }, on: :create
  validates :nickname, uniqueness: true, length:{minimum:5,maximum:20}
  validates :email, uniqueness: true, length:{minimum:6,maximum:32}, format: { with: REGEX_EMAIL }

  before_create -> {self.password = Digest::SHA256.new << self.password }
end
