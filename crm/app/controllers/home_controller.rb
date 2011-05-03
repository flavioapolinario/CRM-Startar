class HomeController < ApplicationController
  skip_before_filter :require_user
  before_filter :load_items
  
  def index
    if current_user
      @tasks = current_user.tasks
      @incomplete_tasks = current_user.tasks.open
      @completed_tasks = current_user.tasks.closed
    end
  end

  def finish
    @task = current_user.tasks.find(params[:id].gsub(/\D/, ""))
    #@task = current_user.tasks.find(params[:id])
    @task.update_attribute("status", "closed")
  end

  def save
    @task = Task.new(params[:task].merge({ :status => "open" }))
    @task.owner = current_user
    @task.save

    respond_to do |format|
      format.js
      format.html do
        if @task.valid?
          redirect_to root_url
        else
          render :action => "index"
        end
      end
    end
  end
  
  protected
  def load_items
    @projects = Project.find(:all).collect { |p| [p.name, p.id] }
  end
  
end
