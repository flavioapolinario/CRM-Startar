class TaskNotifier < ActionMailer::Base
  
  def update_notification(user, task)
    recipients %('#{user.name}' <#{user.email}>)
    from "flavioapolinario@hotmail.com"
    subject "Task Update Notification"
    body :user => user, :task => task
    content_type "text/html"
  end
   
end
