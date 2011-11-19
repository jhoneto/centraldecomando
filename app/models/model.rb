# encoding: UTF-8

class Model < ActiveRecord::Base
  
  TICKET = "Ticket"
  
  MODELS = {
    TICKET => "Tarefas"
    }
    
  MODELS_LIST = [["Tarefas", TICKET]]
  
end