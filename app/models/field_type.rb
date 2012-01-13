# encoding: UTF-8

class FieldType <ActiveRecord::Base
    
  TEXT = 1
  MEMO = 2
  DATE = 3
  NUMBER = 4
  IMAGE = 5  
  
  FIELD_TYPE = {          
    TEXT => "Texto",
    MEMO => "Memo",
    DATE => "Data",
    NUMBER => "Númerico",
    IMAGE => "Imagem"
  }
  
  FIELD_TYPE_LIST = [["Texto", TEXT],["Memo", MEMO], ["Data", DATE], ["Númerico", NUMBER], ["Imagem", IMAGE]]           
  

end