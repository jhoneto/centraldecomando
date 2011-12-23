class Sprint < ActiveRecord::Base
  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
  
  has_many :stories_sprints, :class_name => "StorySprint"
  has_many :stories, :through => :stories_sprints
  
  has_many :tickets_sprints, :class_name => "TicketSprint"
  has_many :tickets, :through => :tickets_sprints       
  
  
  def close 
    if self.status != 3                                         
      self.tickets_sprints.each do |ts|
        ticket_sprint = TicketSprint.find(ts.id) 
        if ticket_sprint.ticket.ticket_status.final == true
          puts 'ENCERRANDO'         
          ticket_sprint.closed = true
          ticket_sprint.save
        else                        
          puts 'REABRINDO'
          t = ts.ticket
          t.ticket_status = TicketStatus.find_by_initial(true)   
          t.save
        end
      end 
    
      self.status = 3 #Cancelado
      self.save 
      true
    else
      false
    end
  end
  
end
