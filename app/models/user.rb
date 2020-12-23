class User < ApplicationRecord
    has_many :background
    has_many :like
    validates_presence_of :nickname, :email, :password
    validates :password, length:{minimum:8,maximum:32}
    validates :nickname, length:{minimum:5,maximum:20}
    validates :email, length:{minimum:6,maximum:32}
end
