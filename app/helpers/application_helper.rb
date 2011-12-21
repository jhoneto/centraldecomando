module ApplicationHelper             
  
  def generic_search_window_tag(options)

    options = {
        :text_readonly => true,
        :field_two_width => 15
        }.merge(options)

    options_grid = {:on_document_ready => true, :html_tags => false}


    table = options[:name] + "_grid"


    html = "<div id='fields_#{options[:name]}'>"
    html << hidden_field_tag(options[:field_id], options[:value_id], :class => 'text_field', :style => "width:10%", :id => "#{options[:name]}_id")
    html << search_field_tag(options[:field_text], options[:value_text], :class => 'text_field', :readonly => options[:text_readonlyo], :style => "width:89%", :id => "#{options[:name]}_title", :ondblclick => "search_#{options[:name]}()")
    html << "</div>"
    html << "<div id=#{options[:name]}_window_search style='display: none'>"
    html << "<div id='search_#{options[:name]}'>"
    html << render(:partial => options[:search])
    html << "</div>"
    html << "<button id='#{options[:name]}submitButton' name = 'button' style='margin-left:30px;'>Buscar</button>"
    html << "<table id='#{options[:name]}_grid'></table>"
		html << "<div id='#{options[:name]}_pager'></div>"
    html << "</div>"




    script = "<script type='text/javascript'>"
    script << "function search_#{options[:name]}(){"
    script << "    $( '##{options[:name]}_window_search' ).dialog( 'open' );"
    script << "    return false;"
    script << " }"
    script << "$(function() { "
    script << "   $('##{options[:name]}submitButton').click(function(){"
    script << "     var $inputs = $('#search#{options[:name]} :input');"
    script << "     var txt_values = '';"
    script << "     $inputs.each(function() {"
    script << "         txt_values = txt_values + this.name; txt_values = txt_values + '=' + $(this).val() + '&'; "
    script << "     });"
    script << "     gridReload#{options[:name]}(txt_values); "
    script << "  });"
    script << "   $('##{options[:name]}_window_search').dialog({autoOpen: false, modal: true, height: 400, width: 600,"
    script << "                         buttons:{ "
    script << "                             OK: function() {"
    script << "                                  var row = jQuery('##{options[:name]}_grid').jqGrid('getGridParam', 'selrow');"
    script << "                                  if(row){ "
    script << "                                    var data = jQuery('##{options[:name]}_grid').jqGrid('getRowData', row);"
    script << "                                    $('input[id$=#{options[:name]}_id]').val(data.#{options[:id]});"
    script << "                                    $('input[id$=#{options[:name]}_title]').val(data.#{options[:description]});"
    script << "                                    $( this ).dialog( 'close' );"
    script << "                                  } else {"
    script << "                                    alert('Selecione um registro');"
    script << "                                  }},"
    script << "                              Cancelar: function() { 	$( this ).dialog('close');}"
    script << "                             }"

    script << "   });"
    script << "});"
    script << " function gridReload#{options[:name]}(filtro){ "
    script << "   	$('##{table}')."
    script <<	"	  jqGrid('setGridParam', "
    script << "			{url:'/#{options[:url]}?' + filtro ,"
    script <<	" 		 page:1 "
    script << "			}).trigger('reloadGrid');"
    script << "	} "
    script << "</script>"

    grid = [{
      :url => "/#{options[:url]}",
      :datatype => 'json',
      :mtype => 'GET',
      :autowidth => true,
      :autoheight => true,
      :colNames => options[:captions],
      :colModel  => options[:columns],
      :pager => "#" + options[:name] + "_pager",
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :caption => options[:caption]
    }]

    pager = [:navGrid,  "#" + options[:name] + "_pager", {:pdf => true, :add => false, :edit => false, :del => false,  :search => false}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]

    script_grid = jqgrid_api options[:name] + "_grid", grid, pager, options_grid

    return html + script_grid + script

  end
end
