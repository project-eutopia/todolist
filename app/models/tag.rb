class Tag < ActiveRecord::Base
  attr_accessible :title
  
  belongs_to :user
  
  has_and_belongs_to_many :todos
end
