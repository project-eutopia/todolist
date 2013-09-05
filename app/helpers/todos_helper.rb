module TodosHelper

  def count
    Todo.all.size
  end
  
  def incomplete_count
    sum = 0
    
    Todo.all.each do |todo|
      if todo.done == false
        sum += 1
      end
    end
    
    sum
  end
  
  def search_count
    @todos.size
  end

end
