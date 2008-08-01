class TopicsController < ApplicationController
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])

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

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
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

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
        format.html { redirect_to(@topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(topics_url) }
      format.xml  { head :ok }
    end
  end
  
  def tag
    @topic = Topic.find(params[:id])
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

end
