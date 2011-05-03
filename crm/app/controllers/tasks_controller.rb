class TasksController < ApplicationController
  before_filter :load_users,:load_projects, :only => [:new, :edit, :create, :update]
  
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.rss # index.rss.builder
      format.xml  { render :xml => @tasks }
    end
  end
  
  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end
  
  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end
  
  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end
  
  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task, :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    
    respond_to do |format|
      if @task.update_attributes(params[:task])
        notify_users
        format.html { redirect_to(@task, :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end

  # GET /tasks/urgent
  # GET /tasks/urgent.xml
  def urgent
    @tasks = Task.open.high    
    respond_to do |format|
      format.html
      format.xml { render :xml=>@tasks }
    end
  end

  protected
  # Carrega os @users
  def load_users
    @users = User.all.collect { |u| [u.name, u.id] }
  end
  
  # Carrega os @projects
  def load_projects
    @projects = Project.all.collect { |p| [p.name, p.id] }
  end
  
  def notify_users
    @task.project.members.each do |member|
      TaskNotifier.deliver_update_notification(member, @task)
    end
  end
  
end
