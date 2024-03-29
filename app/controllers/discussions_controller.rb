class DiscussionsController < ApplicationController

  before_action :set_discussion, only: [:show, :edit, :update, :destroy] 
  # Call the method to get all topics and order them via created date
  # on pages index, show, new and edit
  before_action :find_topics, only: [:index, :show, :new, :edit]
  # Only allow users that are NOT signed in to view index and show
  # before_action :authenticate_user!, except: [:index, :show]

  # GET /discussions
  # GET /discussions.json
  def index
    # returns a list of discussions where the creation date is within the last 30 days
    # @discussions = Discussion.where('created_at > ?', 30.days.ago)
    if params[:toggle]
    @discussions = Discussion.order(params[:sort]).where(topic_id: params[:toggle]).order('created_at desc')
  else
    @discussions = Discussion.order(params[:sort]).
        where('created_at > ?', 30.days.ago)
    end
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @discussions = Discussion.all.order('created_at desc')
    @discussion.increment
  end

  # GET /discussions/new
  def new
    if current_user
      @discussion = current_user.discussions.new
    else
      flash[:notice] = 'Please login before creating a discussion'
      redirect_to login_path
    end
  end

  # GET /discussions/1/edit
  def edit
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = current_user.discussions.build(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to discussions_url, notice: 'Discussion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def find_topics
    @topics = Topic.all.order('created_at desc')
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def discussion_params
    params.require(:discussion).permit(:title, :content, :topic_id)
  end
end
