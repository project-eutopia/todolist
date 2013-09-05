class Todo < ActiveRecord::Base
  attr_accessible :done, :todo
  
  paginates_per 5
  
  validates :todo, presence: true
  
  # Want to initialize done to false (i.e. incomplete task)
  after_initialize :default_values
  def default_values
    # Set if not nil
    self.done ||= false
  end
  
  def self.search(phrase)
    if phrase
      find(:all, conditions: ['todo LIKE ?', "%#{phrase}%"])
    else
      find(:all)
    end
  end
  
end
