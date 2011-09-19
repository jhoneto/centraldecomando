#encoding: UTF-8
require 'rake'

namespace :cc do
  
  task :criar_conta_inicial => :environment do
    account = Account.create({:name => "Conta default"})
    user = User.create({:email => "jhamilton.oliveira@gmail.com", :username => "admin",
                        :name => "Administrador", :account_id => account.id,
                        :password => "admin"})
  end
  
  task :criar_status => :environment do
    aberto = TicketStatus.create({:name => "Aberto", :account_id => 1,
                                  :first => false, :final => false,
                                  :initial => true})
    desenv = TicketStatus.create({:name => "Em Desenvolvimento", :account_id => 1,
                                  :first => true, :final => false,
                                  :initial => false})
    concluido = TicketStatus.create({:name => "Concluído", :account_id => 1,
                                     :first => false, :final => false,
                                     :initial => false})
    liberado = TicketStatus.create({:name => "Liberado", :account_id => 1,
                                    :first => false, :final => true,
                                    :initial => false})
    cancelado = TicketStatus.create({:name => "Cancelado", :account_id => 1,
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
  
  task :criar_ticket_type => :environment do
    erro = TicketType.create({:name => "Erro"})
    manutecao = TicketType.create({:name => "Manutenção"})
    evolucao = TicketType.create({:name => "Evolução"})
  end
  
  task :reiniciar_senha , :id , :needs => :environment do |t, args| 
    user = User.find(args[:id])
    user.update_password('123456')
  end

end