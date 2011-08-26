class Ticket < ActiveRecord::Base
  before_create :set_date_of_registration
  belongs_to :project
  belongs_to :client
  belongs_to :user_registration, :class_name => "User", :foreign_key => "user_registration_id"
  belongs_to :user_owner, :class_name => "User", :foreign_key => "user_owner_id"
  belongs_to :ticket_type, :class_name => "TicketType", :foreign_key => "ticket_type_id"
  belongs_to :ticket_status, :class_name => "TicketStatus", :foreign_key => "ticket_status_id"
  
  validates_presence_of :user_owner_id
  validates_presence_of :user_registration_id
  validates_presence_of :ticket_type
  validates_presence_of :ticket_status_id
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :project
  
  def set_date_of_registration
    self.date_of_registration = Time.now
  end
  
  
  def self.get_tickets(options)
    busca = where('account_id = ?', options[:account_id])
    busca = busca.where('project_id = ?', options[:project_id]) unless (options[:project_id].nil? || options[:project_id] == '')
    busca = busca.where('client_id = ?', options[:client_id]) unless (options[:client_id].nil? || options[:client_id] == '')
    busca = busca.where('title like ?', "%#{options[:title]}%") unless (options[:title].nil? || options[:title] == '')
    busca = busca.where('description like ?', "%#{options[:description]}%") unless (options[:description].nil? || options[:description] == '')
    busca = busca.where('ticket_status_id = ?', options[:ticket_status_id]) unless (options[:ticket_status_id].nil? || options[:ticket_status_id] == '')
    busca = busca.where('ticket_type_id = ?', options[:ticket_type_id]) unless (options[:ticket_type_id].nil? || options[:ticket_type_id] == '')
    busca.all
  end
  
  
end
