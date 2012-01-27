class TicketsSprintsController < ApplicationController  
  layout "bootstrap_full_content"
  
  def index
    @sprint = Sprint.find(params[:sprint_id])
    @tickets_sprints = @sprint.tickets_sprints.paginate(:page => params[:page], :per_page => 10)
    @ticket_sprint = TicketSprint.new
    @team = ProjectMember.where("project_id = ?", @sprint.project_id)
  end                 
  
  
  def save
      
    if params[:id] == ''                             
      @ticket_sprint = TicketSprint.new
      @ticket_sprint.ticket_id = params[:ticket_id]
      @ticket_sprint.sprint_id = params[:sprint_id] 
      @ticket_sprint.estimate = params[:estimate]
      if @ticket_sprint.save     
        @sprint = Sprint.find(params[:sprint_id])    
        @tickets_sprints = @sprint.tickets_sprints.paginate(:page => params[:page], :per_page => 10)
      end
    else       
      @ticket_sprint = TicketSprint.find(params[:id])
      @ticket_sprint.ticket_id = params[:ticket_id]
      @ticket_sprint.sprint_id = params[:sprint_id] 
      @ticket_sprint.estimate = params[:estimate]
      if @ticket_sprint.save
        @sprint = Sprint.find(params[:sprint_id])    
        @tickets_sprints = @sprint.tickets_sprints.paginate(:page => params[:page], :per_page => 10)
      end
    end
  end    
  
  def edit   
    @sprint = Sprint.find(params[:sprint_id])    
    @ticket_sprint = TicketSprint.find(params[:id]) 
  end   
  
  def destroy
    @ticket_sprint = TicketSprint.find(params[:id])
    @ticket_sprint.destroy


    @sprint = Sprint.find(params[:sprint_id])
    @tickets_sprints = @sprint.tickets_sprints.paginate(:page => params[:page], :per_page => 10)
  end        
  
  
end
