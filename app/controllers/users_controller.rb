class UsersController < ApplicationController

  def index
    @user = current_user
    
    # Restrict to only todos owned by the user
    @todos = Todo.where(user_id: @user.id)
    if params[:filter_tag_id].present?
      @tag = Tag.find_by_id(params[:filter_tag_id])
      if @tag
        @todos = @tag.todos
      end
    end
    
    # Reference for pagination help:
    # http://fourthslap.blogspot.jp/2011/04/kaminari-beautiful-pagination-gem-for.html
    if params[:search].present?
      array = @user.search(params[:search])
      @todos_paged = Kaminari::PaginatableArray.new( array ).page(params[:page])
      @total_todos = array.size
    else
      @todos_paged = @todos.page(params[:page])
      @total_todos = @todos.size
    end
  end
  
  def splash
  end

  def remove_all_complete
    @user = current_user
    @user.remove_all_complete

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
  
  def clear_search
    params[:search] = nil
    render index
  end
  
end