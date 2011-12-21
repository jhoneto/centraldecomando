# encoding: UTF-8

class Role <ActiveRecord::Base
    
  SCRUM_MASTER = 1
  PRODUCT_OWNER = 2
  DEVELOPER = 3
  
  ROLE = {
    SCRUM_MASTER => "Scrum Master",
    PRODUCT_OWNER => "PO",
    DEVELOPER => "Desenvolvedor"
  }
  
  ROLE_LIST = [["Scrum Master", SCRUM_MASTER],["Product Owner", PRODUCT_OWNER], ["Desenveolvedor", DEVELOPER]]
end