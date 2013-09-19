class TodosController < ApplicationController
  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.all
    @user = current_user
    @tags = @user.tags

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])
    #@todos = Todo.where(:id>=0).order("id asc").page(params[:page]).per(3)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(params[:todo])
    # Set the user who owns this
    @todo.user = current_user

    respond_to do |format|
      if @todo.save
        format.html { redirect_to root_path, notice: t('todos.success_create') }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])
    
    # If the button was ther "Add tag" button, only need to process the new tag
    if params[:add_tag].present?

      # Only call if the given tag exists for the current user
      if current_user.tags.find_by_id(params[:new_tag_id])
        @todo.add_tag_with_id(params[:new_tag_id])
      end
      
      respond_to do |format|
        format.html { redirect_to edit_todo_path, notice: t('todos.success_add') }
        format.json { head :no_content }
      end
      
    # Here, we are doing a regular update of :todo and :done
    else
    
      respond_to do |format|
      # new_tag_id is not an actual attribute of Todo, so it must be removed from
      # the params[:todo] hash before calling update_attributes below
      if @todo.update_attributes(params[:todo])
          format.html { redirect_to root_path, notice: t('todos.success_update') }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @todo.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: t('todos.success_destroy') }
      format.json { head :no_content }
    end
  end
  
  def finished
    @todo = Todo.find(params[:id])
    @todo.done = true
    @todo.save
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
  
  def remove_tag
    @todo = Todo.find(params[:todo_id])
    @todo.tags.delete(Tag.find_by_id(params[:tag_id]))

    respond_to do |format|
      format.html { redirect_to edit_todo_path, notice: t('todos.tag_removed') }
      format.json { head :no_content }
    end
  end
  
  def add_tag
    Rails.logger.debug("DEBUG add_tag: #{params[:tag_id]}")
    @todo = Todo.find(params[:id])
    @todo.add_tag_with_id(params[:tag_id])

    respond_to do |format|
      format.html { redirect_to edit_todo_path, notice: t('todos.tag_added') }
      format.json { head :no_content }
    end
  end
  
end
