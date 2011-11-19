module FiltersHelper
  
  def dinamic_jqgrid(filter, table, pager, columns_name)
    options = {:on_document_ready => true, :html_tags => false}
    
    grid = [{
          :url => "/filters",
          :datatype => 'json',
          :mtype => 'GET',
          :colNames => columns_name,
          :colModel  => [
            { :name => 'id',   :index => 'id',    :width => 30 },
            { :name => 'title', :index => 'title',  :width => 180 },
          ],
          :autowidth => true,
          :pager => pager,
          :rowNum => 10,
          :rowList => [10, 20, 30],
          :caption => 'Stories'
        }]
        
    pager = [:navGrid, pager, {:del => false, :add => false, :edit => false, :search => false}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    
    jqgrid_api table, grid, pager, options
  end
end
