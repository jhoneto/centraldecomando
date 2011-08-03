class Client < ActiveRecord::Base 
  has_many :tickets
  
  validates_presence_of :name
  validates_presence_of :account_id
end
