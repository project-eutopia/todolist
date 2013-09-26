class Tag < ActiveRecord::Base
  # All tags associated with a single user must be unique
  validates_uniqueness_of :title, scope: :user_id

  attr_accessible :title
  
  belongs_to :user
  has_and_belongs_to_many :todos
end
