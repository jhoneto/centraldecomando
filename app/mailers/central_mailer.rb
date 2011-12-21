class CentralMailer < ActionMailer::Base
  default :from => "delivery@centraldecomando.com.br"
  
  def welcome(user)
    @user = user
    @url  = "http://www.centraldecomando.com.br"
    mail(:to => user.email, :subject => "Bemvindo ao Central de Comando")
  end
end
