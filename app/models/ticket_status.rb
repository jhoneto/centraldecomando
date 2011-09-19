class TicketStatus < ActiveRecord::Base
  belongs_to :next_status, :class_name => "TicketStatus", :foreign_key => "status_next_id"
  belongs_to :prior_status, :class_name => "TicketStatus", :foreign_key => "status_prior_id"
  
  
  def self.get_initial_status(account_id)
    busca = TicketStatus.where("account_id = ? and initial = ?", account_id, true)
    busca.first
    
  end
  
  def self.get_next_status(ticket, account_id)
    if (ticket.ticket_status.initial?)
      status = TicketStatus.where("first = ? and account_id = ?", true, account_id)
      status.all
    else
      status = []
      status << ticket.ticket_status.next_status unless ticket.ticket_status.next_status.nil?
      status << ticket.ticket_status.prior_status unless ticket.ticket_status.prior_status.nil?
    end
    
  end
end
