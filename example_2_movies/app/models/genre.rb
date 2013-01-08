class Genre < ActiveRecord::Base
  has_and_belongs_to_many :movies

  attr_accessible :id, :name
end
