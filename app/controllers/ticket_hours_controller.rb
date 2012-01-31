class TicketHoursController < ApplicationController
  
  def create
    @ticket_hour = TicketHour.new(params[:ticket_hour])
    @ticket_hour.user_id = current_user.id
    @ticket_hour.save
  end
end
