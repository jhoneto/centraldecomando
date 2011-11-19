class TicketSprint < ActiveRecord::Base
  belongs_to :ticket, :class_name => "Ticket", :foreign_key => "ticket_id"
  belongs_to :sprint, :class_name => "Sprint", :foreign_key => "sprint_id"
end
