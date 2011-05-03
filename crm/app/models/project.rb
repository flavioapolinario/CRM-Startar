class Project < ActiveRecord::Base
  named_scope :actives, :conditions => {:active => true}
  named_scope :inactives, :conditions => {:active => false}
  
  belongs_to :customer
  has_many :documents
  has_many :contracts
  has_many :tasks
  has_many :implementors, :through => :tasks, :source => :owner

  has_and_belongs_to_many :members, :class_name => "User",
    :join_table => "projects_members",
    :association_foreign_key => "member_id"

  validates_associated :customer
  validates_presence_of :customer
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
end
