class User < ActiveRecord::Base
  include Clearance::User
  
  before_save :create_account
  after_create :send_welcome_email
  
  def email_optional?
    false
  end

  def self.authenticate(username, password) 
    return nil unless user = find_by_username(username) 
    return user if user.authenticated?(password) 
  end
  
  
  def create_account
    if new_record? && !self.account_id
      account = Account.new
      account.name = "Preecha o nome da sua empresa"
      account.save
      self.account_id = account.id
      self.admin = true
    end
  end
       
  def send_welcome_email 
    CentralMailer.welcome(self).deliver
  end
  
end
