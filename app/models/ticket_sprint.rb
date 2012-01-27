# encoding: UTF-8
class TicketSprint < ActiveRecord::Base
  belongs_to :ticket, :class_name => "Ticket", :foreign_key => "ticket_id"
  belongs_to :sprint, :class_name => "Sprint", :foreign_key => "sprint_id" 
  
  after_save :update_capacity
  after_destroy :update_capactiy
  
  attr_reader :ticket_title
  
  validates_uniqueness_of :ticket_id, :scope => [:sprint_id]     
  validates_presence_of :ticket_id, :on => :create
  validates_presence_of :estimate, :on => :create
  validate :valid_status_ticket, :on => :create   
  
  
  scope :chart_performance, lambda{ 
    {
      :select => "tickets_sprints.*, sprints.sequence, sprints.project_id, sprints.date_of_beginning",
      :joins => ("right join sprints on sprints.id = sprint_id")
    }
  }  
  
  def update_capactiy
    sprint = Sprint.find(self.sprint_id)
    estimated = TicketSprint.where("sprint_id = ?", self.sprint_id).sum(:estimate)
    sprint.estimated = estimated
    sprint.save
  end
  def valid_status_ticket
    unless self.ticket.nil?
      if !self.ticket.ticket_status.initial
        errors.add(:ticket_id, "Item de backlog deve está aberto")
      end
    end
  end
  
  def ticket_title 
    self.ticket.nil? ? '' : self.ticket.title
  end   
  
  
end
