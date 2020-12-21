class User < ApplicationRecord
  require 'digest'
  validates :name, presence: true
  validates :email, presence: true, uniquenes: true
  validates :password, presence: true
  
  before_create -> { self.password = Digest::SHA256.new << self.password }
end
