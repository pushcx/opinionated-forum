class UsersController < ApplicationController
  before_filter :load_user, :except => :index
  before_filter :only_self_or_admin, :only => [ :edit, :update ]
  before_filter :require_login, :only => [ :edit, :update ]

  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    respond_to do |format|
      format.html { }
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    respond_to do |format|
      @user.admin = params[:user][:admin] if @current_user.admin?
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def only_self_or_admin
    return true if @current_user == @user or @current_user.admin?
    flash[:error] = "No editing other users"
    redirect_to :action => :show and return false
  end
end
