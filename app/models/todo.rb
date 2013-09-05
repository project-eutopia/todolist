class Todo < ActiveRecord::Base
  attr_accessible :done, :todo
  
  validates :todo, presence: true
  
  # Want to initialize done to false (i.e. incomplete task)
  after_initialize :default_values
  def default_values
    # Set if not nil
    self.done ||= false
  end
  
end
