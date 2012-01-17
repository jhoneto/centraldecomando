class Ticket < ActiveRecord::Base     
  has_paper_trail
  
  before_create :set_date_of_registration  
  after_update  :send_message_update
  
  belongs_to :project
  belongs_to :client
  belongs_to :user_registration, :class_name => "User", :foreign_key => "user_registration_id"
  belongs_to :user_owner, :class_name => "User", :foreign_key => "user_owner_id"
  belongs_to :ticket_type, :class_name => "TicketType", :foreign_key => "ticket_type_id"
  belongs_to :ticket_status, :class_name => "TicketStatus", :foreign_key => "ticket_status_id"  
  belongs_to :priority, :class_name => "Priority", :foreign_key => "priority_id" 
  belongs_to :specification, :class_name => "Specification", :foreign_key => "specification_id"
  
  validates_presence_of :user_owner_id
  validates_presence_of :user_registration_id
  validates_presence_of :ticket_type
  validates_presence_of :ticket_status_id
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :project     
  
  default_scope :order => "id ASC"
  
  scope :with_title_or_description, lambda {|parameter| where("upper(title) like upper(?) or upper(description) like upper(?)", "%#{parameter}%", "%#{parameter}%")}
  scope :with_project, lambda{|parameter| where("project_id = ?", parameter)}
  scope :with_status, lambda{|parameter| where("ticket_status_id = ?", parameter)}
  scope :with_type, lambda{|parameter| where("ticket_type_id = ?", parameter)}
  scope :with_client, lambda{|parameter| where("client_id = ?", parameter)}
  scope :with_priority, lambda{|parameter| where("priority_id = ?", parameter)}     
  scope :with_id_or_title, lambda{|parameter| where("cast(id as text) = ? or upper(title) like upper(?)", parameter, "%#{parameter}%")}
  scope :with_id, lambda{|parameter| where("cast(id as text) = ?", parameter)}
  
  # Scope para filtro dinamico
  scope :dinamic_filter, lambda{ 
    {
      :select => "tickets.*, clients.name client_name, projects.name project_name, ticket_types.name ticket_type_name, ticket_status.name ticket_status_name",
      :joins => ("left outer join clients on clients.id = client_id inner join projects on projects.id = project_id inner join ticket_types on ticket_types.id = ticket_type_id inner join ticket_status on ticket_status.id = ticket_status_id")
    }
  } 
  
  # Scope para gráfico por tipo de item
  scope :chart_by_type, lambda{
    {
      :select => "count(t.*)",
      :joins => ("inner join ticket_types  on tickets.ticket_type_id = ticket_types.id
                  inner join tickets_sprints  on tickets.id = tickets_sprints.ticket_id")
    }
  }     
  
  # Scope para gráfico por tipo de item
  scope :chart_by_status, lambda{
    {
      :select => "count(t.*)",
      :joins => ("inner join ticket_status  on tickets.ticket_status_id = ticket_status.id
                  inner join tickets_sprints  on tickets.id = tickets_sprints.ticket_id")
    }
  }  
  
  
  def send_message_update       
    pms = ProjectMember.where('project_id = ?', self.project_id)
    pms.each do |pm|         
      if pm.role == Role::SCRUM_MASTER || pm.role == Role::DEVELOPER
        user = User.find(pm.user_id)
        CentralMailer.alter_ticket(user, self).deliver
      end
    end
  end
  
  def self.search(parameters, account)
    ticket_query = self.scoped
    ticket_query =  ticket_query.where('tickets.account_id = ?', account)
    parameters.each do |parameter, value|
      if not value.empty? and ticket_query.respond_to? parameter
        ticket_query = ticket_query.send(parameter, value)
      end
    end
    ticket_query
  end
  
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
