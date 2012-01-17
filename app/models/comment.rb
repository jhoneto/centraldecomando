class Comment < ActiveRecord::Base                                  
  
  #after_create :send_message
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates_presence_of :comment, :on => :create, :message => "can't be blank"     
  
  def send_message
    if self.comment_type == 1
      ticket = Ticket.find(self.process_id)
      pms = ProjectMember.where('project_id = ?', ticket.project_id)
        pms.each do |pm|         
        if pm.role == Role::SCRUM_MASTER || pm.role == Role::DEVELOPER
          user = User.find(pm.user_id)
          CentralMailer.send_comment(user, ticket, self).deliver
        end
      end
    end
  end
end
