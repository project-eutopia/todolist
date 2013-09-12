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
  
  def self.count
    Todo.all.size
  end
  
  def self.incomplete_count
    sum = 0
    
    Todo.all.each do |todo|
      if todo.done == false
        sum += 1
      end
    end
    
    sum
  end
  
  def self.search_count
    Todo.all.size
  end

  def self.remove_all_complete
    Todo.all.each do |todo|
      if todo.done == true
        todo.destroy
      end
    end
  end
  
end
