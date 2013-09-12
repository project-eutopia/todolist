class User < ActiveRecord::Base
  # User has many todos
  has_many :todos
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  # For searching
  def search(phrase)
    if phrase
      find(:all, conditions: ['todo LIKE ?', "%#{phrase}%"])
    else
      find(:all)
    end
  end
  
  def search_count
    Todo.all.size
  end
  
  # Statistics
  def count
    self.todos.size
  end
  
  def incomplete_count
    sum = 0
    
    self.todos.each do |todo|
      if todo.done == false
        sum += 1
      end
    end
    
    sum
  end
  
  def remove_all_complete
    self.todos.each do |todo|
      if todo.done == true
        todo.destroy
      end
    end
  end
end
