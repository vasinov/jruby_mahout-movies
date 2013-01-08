class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  attr_accessible :user_id, :item_id, :rating, :created_at, :updated_at
end