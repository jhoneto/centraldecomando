module StoriesHelper
  
  include JqgridsHelper
  
  def search_stories_jqgrid
    options = {:on_document_ready => true, :html_tags => false}
    
    grid = [{
          :url => "/stories",
          :datatype => 'json',
          :mtype => 'GET',
          :colNames => ['Id','Como', 'Desejo'],
          :colModel  => [
            { :name => 'id',   :index => 'id',    :width => 30 },
            { :name => 'as_a', :index => 'as_a',  :width => 180 },
            { :name => 'i_want_to', :index => 'i_want_to',  :width => 400 },
          ],
          :pager => '#stories_pager',
          :rowNum => 10,
          :rowList => [10, 20, 30],
          :caption => 'Stories'
        }]
        
    pager = [:navGrid, "#stories_pager", {:del => false, :add => false, :edit => false, :search => false}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    
    jqgrid_api 'stories_list', grid, pager, options
  end
  
end
