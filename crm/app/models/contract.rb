class Contract < ActiveRecord::Base
  STATUS = %w(prospecting acceppted canceled)

  belongs_to :leader, :class_name=>"User", :foreign_key=>"leader_id"
  belongs_to :project
  
  validates_associated :project, :leader
  #%w tipos de status: prospecting, accepted, canceled
  validates_inclusion_of :status, :in => STATUS
  validates_presence_of :name, :leader, :project,:code, :description, :started_at

end
