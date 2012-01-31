class TicketHour < ActiveRecord::Base
  
  before_create :set_active_sprint
  
  def set_active_sprint
    ticket_sprint = TicketSprint.joins(:sprint).where("ticket_id = ? and sprints.status = 1", self.ticket_id)[0]
    self.sprint_id = ticket_sprint.sprint_id
  end
end
