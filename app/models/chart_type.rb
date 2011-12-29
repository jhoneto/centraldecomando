# encoding: UTF-8

class ChartType <ActiveRecord::Base
    
  DESEMPENHO = 1    
  POR_TIPO_ITEM = 2 
  POR_STATUS_ITEM = 3
  
  CHART_TYPE = {
    DESEMPENHO => "Desempenho",
    POR_TIPO_ITEM => "Por tipo de item",
    POR_STATUS_ITEM => "Por status do item"
  } 
  
  CHART_PARTIAL = {
    DESEMPENHO => "performance",
    POR_TIPO_ITEM => "by_item_type",
    POR_STATUS_ITEM => "by_item_status"
  }
  
  CHART_TYPE_LIST = [["Desempenho", DESEMPENHO], ["Por tipo de item", POR_TIPO_ITEM], ["Por status do item", POR_STATUS_ITEM]]
end