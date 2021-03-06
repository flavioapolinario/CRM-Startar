class UsersController < ApplicationController
  skip_before_filter :require_user
  # GET /users
  # GET /users.xml
  def index
    @users = User.paginate :page => params[:page],
      :conditions => ["id <> ? ", "#{current_user.id}"],
      :order => 'name ASC', :per_page => 4
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  #  def show
  #    @user = User.find(params[:id])
  #
  #    respond_to do |format|
  #      format.html # show.html.erb
  #      format.xml  { render :xml => @user }
  #    end
  #  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  # POST /users
  def create
    @user = User.new(params[:user])    
    if @user.save
      flash[:notice] = t("SucessfullyCreated")
      redirect_to root_url
    else
      render :action => "new"
    end
  end
  # GET /users/1/edit
  def edit
    #@user = current_user
    @user = User.find(params[:id])
  end
  # PUT /users/1
  def update
    #@user = current_user
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = t("SucessfullyUpdated")
      redirect_to root_url
    else
      render :action => "edit"
    end
  end
 
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
