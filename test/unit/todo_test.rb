require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  
  test "proper product validation" do
    todo = Todo.new
    
    # Must initialize to false
    assert (todo.done == false)
    
    # Can't be empty
    assert todo.invalid?
    assert_equal todo.errors[:todo], ["can't be blank"]
    
    # Can't be whitespace
    todo.todo = "  "
    assert todo.invalid?
    assert_equal todo.errors[:todo], ["can't be blank"]
    
    todo.todo = "okay"
    assert todo.valid?
  end
  
end
