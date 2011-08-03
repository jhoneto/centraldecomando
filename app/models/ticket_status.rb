class TicketStatus < ActiveRecord::Base
  belongs_to :next_status, :class_name => "TicketStatus", :foreign_key => "status_next_id"
  belongs_to :prior_status, :class_name => "TicketStatus", :foreign_key => "status_prior_id"
  
  
  def self.get_first_status(account_id)
    busca = where("account_id = ? and first = true", account_id)
    busca.first
  end
end
