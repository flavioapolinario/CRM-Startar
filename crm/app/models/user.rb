class User < ActiveRecord::Base
  acts_as_authentic

  KIND = %w(administrator user)

  #associações
  has_many :contracts
  has_many :tasks, :foreign_key => "owner_id"

  #validações
  validates_presence_of :name, :email
  validates_inclusion_of :kind, :in => KIND

  #namescope
  named_scope :open, :conditions => { :status => "open" }
  
  # Versao antiga
  #  acts_as_authentic
  #
  #  KIND = %w(administrator user)
  #
  #  validates_presence_of :name, :login, :password
  #  validates_uniqueness_of :login
  #  validates_length_of :login, :within => 5..16
  #  validates_length_of :password, :within => 5..255
  #  #%w tipos de status: prospecting, accepted, canceled
  #  validates_inclusion_of :kind, :in => KIND
  #
  #  # valida a senha
  #  validates_confirmation_of :password, :if => :password_changed?




end
