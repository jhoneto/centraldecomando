module TicketsHelper
  
  include JqgridsHelper
  
  def search_tickets_jqgrid
    options = {:on_document_ready => true, :html_tags => false}
    
    grid = [{
          :url => "/tickets",
          :datatype => 'json',
          :mtype => 'GET',
          :colNames => ['Id','Titulo'],
          :colModel  => [
            { :name => 'id',   :index => 'id',    :width => 30 },
            { :name => 'title', :index => 'title',  :width => 580 }
          ],
          :pager => '#tickets_pager',
          :rowNum => 10,
          :rowList => [10, 20, 30],
          :caption => 'Tickets'
        }]
        
    pager = [:navGrid, "#tickets_pager", {:del => false, :add => false, :edit => false, :search => false}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    
    jqgrid_api 'tickets_list', grid, pager, options
  end
  
end
