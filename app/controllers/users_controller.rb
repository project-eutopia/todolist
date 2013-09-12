class UsersController < ApplicationController

  def index
    @user = current_user
    
    # Restrict to only todos owned by the user
    @todos = Todo.where(user_id: @user.id)
    
    if params[:search].present?
      array = @todos.search(params[:search])
      @todos_paged = Kaminari::PaginatableArray.new( @array ).page(params[:page])
    else
      @todos_paged = @todos.page(params[:page])
    end
  end
  
  def splash
  end

end