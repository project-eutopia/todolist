class TagsController < ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    @tags = current_user.tags

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag = current_user.tags.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])
    @tag.user = current_user

    respond_to do |format|
      if @tag.save
        # If we came from editing a Todo, go back there
        if params[:return_todo_id].present?
          format.html { redirect_to edit_todo_path(id: params[:return_todo_id]), notice: t('tags.success_create') }
        else
          format.html { redirect_to @tag, notice: t('tags.success_create') }
        end
        format.html { redirect_to @tag, notice: t('tags.success_create') }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: t('tags.success_update') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end


end
