module GridsHelper
  
  include JqgridsHelper
  
  def projects_jqgrid
    
     options = {:on_document_ready => true, :html_tags => false}

      grid = [{
        :url => '/projects',
        :datatype => 'json',
        :mtype => 'GET',
        :colNames => ['ID','Nome'],
        :colModel  => [
          { :name => 'id',   :index => 'id',    :width => 180 },
          { :name => 'name', :index => 'name',  :width => 500 },
        ],
        :pager => '#projects_pager',
        :rowNum => 10,
        :rowList => [10, 20, 30],
        :caption => 'My first grid',
        :onSelectRow => "function() { alert('Row selected!');}".to_json_var
      }]
      
      pager = [:navGrid, "#projects_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]

      pager_button = [:navButtonAdd, "#projects_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

      jqgrid_api 'projects_list', grid, pager, pager_button, options

    end
end