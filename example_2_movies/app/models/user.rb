class User < ActiveRecord::Base
  has_many :preferences
  has_many :movies, :through => :preferences

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :id, :email, :password, :password_confirmation, :remember_me,
                  :age, :gender, :occupation, :zip
end
