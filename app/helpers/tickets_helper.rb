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
  
  def search_tickets_for_sprint_jqgrid(project_id)    
    status_aberto = TicketStatus.find_by_account_id_and_initial(current_user.account_id, true)
    
    options = {:on_document_ready => true, :html_tags => false}
    
    grid = [{
          :url => "/tickets?with_project=#{project_id}&with_status=#{status_aberto.id}",
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
