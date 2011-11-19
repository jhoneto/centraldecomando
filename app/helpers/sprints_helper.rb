module SprintsHelper
  
  include JqgridsHelper
  
  def stories_sprints_jqgrid(sprint)
    options = {:on_document_ready => true, :html_tags => false}
    
    grid = [{
          :url => "/sprints/get_stories/#{sprint}",
          :datatype => 'json',
          :mtype => 'GET',
          :colNames => ['Id','Como', 'Desejo'],
          :colModel  => [
            { :name => 'id',   :index => 'id',    :width => 30 },
            { :name => 'as_a', :index => 'as_a',  :width => 180 },
            { :name => 'i_want_to', :index => 'i_want_to',  :width => 400 },
          ],
          :pager => '#stories_sprints_pager',
          :rowNum => 10,
          :rowList => [10, 20, 30],
          :caption => 'Stories do sprint'
        }]
        
    pager_ss = [:navGrid, "#stories_sprints_pager", {:del => false, :add => false, :edit => false, :search => false}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]

    #pager_button = [:navButtonAdd, "#stories_sprints_pager"]
    

    jqgrid_api 'stories_sprints_list', grid, pager_ss, options
  end
  
  def tickets_sprints_jqgrid(sprint)
    options = {:on_document_ready => true, :html_tags => false}
    
    grid = [{
          :url => "/sprints/get_tickets/#{sprint}",
          :datatype => 'json',
          :mtype => 'GET',
          :colNames => ['Id','Titulo'],
          :colModel  => [
            { :name => 'id',   :index => 'id',    :width => 30 },
            { :name => 'title', :index => 'title',  :width => 580 },
          ],
          :pager => '#tickets_sprints_pager',
          :rowNum => 10,
          :rowList => [10, 20, 30],
          :caption => 'Tickets do sprint'
        }]
        
    pager_ss = [:navGrid, "#tickets_sprints_pager", {:del => false, :add => false, :edit => false, :search => false}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]

    #pager_button = [:navButtonAdd, "#stories_sprints_pager"]
    

    jqgrid_api 'tickets_sprints_list', grid, pager_ss, options
  end
  
end
