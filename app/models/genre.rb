class Genre < ActiveRecord::Base
  has_and_belongs_to_many :movies

  attr_accessible :name

  validates_presence_of :name
end
