# encoding: UTF-8

class CentralMailer < ActionMailer::Base
  default :from => "delivery@centraldecomando.com.br"
  
  def welcome(user)
    @user = user
    @url  = "http://www.centraldecomando.com.br"
    mail(:to => user.email, :subject => "Bemvindo ao Central de Comando")
  end
  
  def alter_ticket(user, ticket)    
    @user = user                                        
    @ticket = ticket
    mail(:to => user.email, :subject => "Item de backlog ##{ticket.id} foi modificado") 
  end   
  
  def send_comment(user, ticket, comment)                             
    @user = user                                        
    @ticket = ticket 
    @comment = comment
    mail(:to => user.email, :subject => "Novo comentário no item backlog #{ticket.id}.")
  end
end
