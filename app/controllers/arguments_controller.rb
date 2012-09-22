class ArgumentsController < ApplicationController
  load_and_authorize_resource
  # GET /arguments
  # GET /arguments.json
  def index
    @arguments = Argument.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /arguments/1
  # GET /arguments/1.json
  def show
    @argument = Argument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /arguments/new
  # GET /arguments/new.json
  def new
    @topic = Topic.find(params[:topic_id])
    @argument = @topic.arguments.build
    @argument.sort = params[:sort]

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /arguments/1/edit
  def edit
    @argument = Argument.find(params[:id])
  end

  # POST /arguments
  # POST /arguments.json
  def create
    @topic = Topic.find(params[:topic_id])
    @argument = @topic.arguments.build(params[:argument])
    @argument.user = current_user

    respond_to do |format|
      if @argument.save
        format.html { redirect_to @topic, notice: 'Argument was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /arguments/1
  # PUT /arguments/1.json
  def update
    @argument = Argument.find(params[:id])

    respond_to do |format|
      if @argument.update_attributes(params[:argument])
        format.html { redirect_to @argument, notice: 'Argument was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /arguments/1
  # DELETE /arguments/1.json
  def destroy
    @argument = Argument.find(params[:id])
    @argument.destroy

    respond_to do |format|
      format.html { redirect_to arguments_url }
    end
  end
  
  def upvote
    @topic = Topic.find(params[:topic_id])
    @argument = Argument.find(params[:id])
    @argument.vote :voter => current_user
    redirect_to @topic
  end
  
  def downvote
    @topic = Topic.find(params[:topic_id])
    @argument = Argument.find(params[:id])
    @argument.vote :voter => current_user, :vote => "bad"
    redirect_to @topic
  end
end
