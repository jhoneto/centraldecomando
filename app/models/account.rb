#encoding: UTF-8
class Account < ActiveRecord::Base
  
  after_save :setup
  
  def setup
    aberto = TicketStatus.create({:name => "Aberto", :account_id => self.id,
                                  :first => false, :final => false,
                                  :initial => true})
    desenv = TicketStatus.create({:name => "Em Desenvolvimento", :account_id => self.id,
                                  :first => true, :final => false,
                                  :initial => false})
    concluido = TicketStatus.create({:name => "Concluído", :account_id => self.id,
                                     :first => false, :final => false,
                                     :initial => false})
    liberado = TicketStatus.create({:name => "Liberado", :account_id => self.id,
                                    :first => false, :final => true,
                                    :initial => false})
    cancelado = TicketStatus.create({:name => "Cancelado", :account_id => self.id,
                                     :first => true, :final => false,
                                     :initial => false})
                                  
    desenv.status_prior_id = aberto.id
    desenv.status_next_id = concluido.id
    desenv.save
    
    concluido.status_prior_id = desenv.id
    concluido.status_next_id = liberado.id
    concluido.save
    
    liberado.status_prior_id = concluido.id
    liberado.save
  end
end
