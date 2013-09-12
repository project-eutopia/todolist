class UsersController < ApplicationController

  def index
    @user = current_user
    
    # Restrict to only todos owned by the user
    @todos = Todo.where(user_id: @user.id)
  end
  
  def splash
  end

end