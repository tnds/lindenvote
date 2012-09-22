class TopicsController < ApplicationController
  load_and_authorize_resource
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @topic_score = @topic.upvotes.size - @topic.downvotes.size
    @total_poll_votes = @topic.poll.votes.size
    if @total_poll_votes == 0
      @poll_upvotes = 0.to_f
      @poll_downvotes = 0.to_f
    else
      @poll_upvotes = ((@topic.poll.upvotes.size.to_f / @total_poll_votes)*100).round
      @poll_downvotes = ((@topic.poll.downvotes.size.to_f / @total_poll_votes)*100).round
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    @topic.user_id = current_user.id

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end
  
  def upvote
    @topic = Topic.find(params[:id])
    @topic.vote :voter => current_user
    redirect_to @topic
  end
  
  def downvote
    @topic = Topic.find(params[:id])
    @topic.vote :voter => current_user, :vote => "bad"
    redirect_to @topic
  end
  
  def upvote_poll
    @topic = Topic.find(params[:id])
    @topic.poll.vote :voter => current_user
    redirect_to @topic
  end
  
  def downvote_poll
    @topic = Topic.find(params[:id])
    @topic.poll.vote :voter => current_user, :vote => "bad"
    redirect_to @topic
  end
end
