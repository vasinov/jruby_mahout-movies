class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  attr_accessible :id, :user_id, :item_id, :rating, :created_at, :updated_at

  validates_presence_of :user_id
  validates_presence_of :item_id
  validates :rating, :inclusion=> { :in => [1, 2, 3, 4, 5] }
end
