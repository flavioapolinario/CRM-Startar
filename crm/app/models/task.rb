class Task < ActiveRecord::Base
  STATUS = %w(open closed)
  PRIORITY = %w(normal low high)

  #associaçoes
  belongs_to :owner, :class_name=>"User", :foreign_key=>"owner_id"
  belongs_to :project

  #validaçoes
  validates_presence_of :title, :description, :owner_id, :project_id
  validates_numericality_of :progress, :only_integer => true, :allow_nil => true
  validates_inclusion_of :status, :in => STATUS
  validates_inclusion_of :priority, :in => PRIORITY

  #callbacks
  after_create :register_create
  after_update :register_update

  #namescope  
  named_scope :open, :conditions => { :status => "open" }
  named_scope :closed, :conditions => { :status => "closed"}
  named_scope :high, :conditions => { :priority => "high" }
  named_scope :low, :conditions => { :priority => "low" }

  def register_create
    Log.create(:message => "Task: '#{self.title}' created by '#{self.owner.name}'.")
  end

  def register_update
    Log.create(:message => "Task '#{self.title}' updated by '#{self.owner.name}'.")
  end
  
end
