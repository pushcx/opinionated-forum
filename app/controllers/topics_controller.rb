class TopicsController < ApplicationController
  before_filter :load_topic, :only => [ :show, :edit, :raw_title, :update_title_of, :destroy, :update_title_of ]
  before_filter :require_login, :except => [ :index, :show ]
  before_filter :only_creator_or_admin, :only => [ :update_title_of ]
  before_filter :mark_topic_read, :only => [ :show ]

  caches_action :show
  cache_sweeper :post_sweeper, :only => [ :tag, :untag, :update_title_of ]

  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.find(:all, :include => [:tags, :posts])
    @topics.sort! {|a,b| b.posts.last.created_at <=> a.posts.last.created_at }
    @tags = Topic.tag_counts.sort {|a,b| b.count <=> a.count }[0..19]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @showed_gravatar = false

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new
    @post  = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # POST /topics
  # POST /topics.xml
  def create
    begin
      Topic.transaction do
        @topic = Topic.new(params[:topic])
        @topic.save!
        @post = @topic.posts.build(params[:post])
        @post.user = @current_user
        @post.save!
        flash[:notice] = 'Topic was successfully created.'
        respond_to do |format|
            format.html { redirect_to(@topic) }
            format.xml  { render :xml => @topic, :status => :created, :location => @topic }
        end
      end
    #rescue
    #  respond_to do |format|
    #    format.html { render :action => "new" }
    #    format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
    #  end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(topics_url) }
      format.xml  { head :ok }
    end
  end

  def tag
    @topic.tag_list.add(params[:tag][:name].split(" "))

    respond_to do |wants|
      if @topic.save
        flash[:notice] = "Tagged topic with #{params[:tag][:name]}."
        wants.html { redirect_to(@topic) }
        wants.xml  { head :ok }
      else
        flash[:error] = "Could not add tag #{params[:tag][:name]}."
        wants.html { redirect_to(@topic) }
        wants.xml  { render :xml => @topic.errors, :status => :unprocessable_entity}
      end
    end
  end

  def untag
    @topic = Topic.find(params[:id])
    @topic.tag_list.remove(params[:tag])
    respond_to do |wants|
      if @topic.save
        wants.html { flash[:notice] = "Tag #{params[:tag]} removed."
                     redirect_to(@topic) }
        wants.xml  { head :ok }
        wants.js   { }
      else
        wants.html { flash[:error] = "Could not remove tag #{params[:tag]}."
                     redirect_to @topic }
        wants.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
        wants.js   { render :update do |page| page.alert("Failed") end }
      end
    end
  end

  def raw_title
    render :text => @topic.title
  end

  def update_title_of
    @topic.title = params[:value]
    if @topic.save
      render :partial => 'title'
    end
  end

  def mark_all_read
    @current_user.mark_all_topics_read
    redirect_to(topics_path)
  end

  private

  def only_creator_or_admin
    return true if @current_user == @topic.posters.first or @current_user.admin?
    flash[:error] = "No editing other others' topics"
    redirect_to :action => :show and return false
  end

  def load_topic
    @topic = Topic.find(params[:id], :include => [:tags, :posts])
  end

  def mark_topic_read
    @topic.read_by(@current_user) if logged_in?
    true
  end

end
