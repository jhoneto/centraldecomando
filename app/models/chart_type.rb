# encoding: UTF-8

class ChartType <ActiveRecord::Base
    
  DESEMPENHO = 1    
  POR_TIPO_ITEM = 2
  
  CHART_TYPE = {
    DESEMPENHO => "Desempenho",
    POR_TIPO_ITEM => "Por tipo de item"
  } 
  
  CHART_PARTIAL = {
    DESEMPENHO => "performance",
    POR_TIPO_ITEM => "by_item_type"
  }
  
  CHART_TYPE_LIST = [["Desempenho", DESEMPENHO], ["Por tipo de item", POR_TIPO_ITEM]]
end