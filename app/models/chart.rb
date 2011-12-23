# encoding: UTF-8

class Chart < ActiveRecord::Base
  serialize :params
  
  def set_params(params)  
    self.params = Hash.new                           
    params.each do |param, value|
      if  (param.include?('chart_')) && (!value.nil?)
          self.params[param] = value
      end  
    end
  end         
  
  def self.execute_chart(chart_id) 
    chart = Chart.find(chart_id) 
    send chart.method, chart
  end
  
  private       
  
  def self.chart_by_type(chart)   
    categories = []   
    first = true
    graf = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:defaultSeriesType] = "column"      
      f.options[:title][:text] = "Por tipo de item do backlog"
      option = chart.params["chart_sprint_option"]
      TicketType.all.each do |tt| 
        data = []
        if option == "1"       
          if chart.params["chart_sprint_option"].nil? 
            data << chart.model.constantize.where("project_id = ? and ticket_type_id = ?", chart.params["chart_project_id"], tt.id).count(); 
          else
            # Gráfico por sprint  
            Sprint.where("project_id = ?", chart.params["chart_project_id"]).each do |s|
              if first == true
                categories << s.sequence
              end
              data << chart.model.constantize.chart_by_type.where("project_id = ? and ticket_type_id = ? and tickets_sprints.sprint_id = ?", chart.params["chart_project_id"], tt.id, s.id).count()
            end
          end
        end
        if option == "2"
          Sprint.where("id = ?", chart.params["chart_sprint_id"]).each do |s|
            if first == true
              categories << s.sequence
            end
            data << chart.model.constantize.chart_by_type.where("project_id = ? and ticket_type_id = ? and tickets_sprints.sprint_id = ?", chart.params["chart_project_id"], tt.id, s.id).count()
          end
        end  
        if option == "3"
          Sprint.limit(chart.params["chart_last_sprints"]).where("project_id = ?", chart.params["chart_project_id"]).each do |s|
            if first == true
              categories << s.sequence
            end
            data << chart.model.constantize.chart_by_type.where("project_id = ? and ticket_type_id = ? and tickets_sprints.sprint_id = ?", chart.params["chart_project_id"], tt.id, s.id).count()
          end
        end          
        f.series(:name=>tt.name, :data=>data)
        first = false
      end 
      # Todos projeto     
     
      f.options[:xAxis][:categories] = categories 
    end
    
    graf
  end
  
  def self.chart_performance(chart)  
    data_total = []
    data_closed = [] 
    categories = []
    graf = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:defaultSeriesType] = "column"      
      f.options[:title][:text] = "Desempenho"    
      option = chart.params["chart_sprint_option"]        
      # Todos os sprints
      if option == "1"   
        if chart.params["chart_sprint_option"].nil? 
          data_total << chart.model.constantize.chart_performance.where("sprints.project_id = ?", chart.params["chart_project_id"]).count 
          data_closed << chart.model.constantize.chart_performance.where("closed = true and project_id = ?", chart.params["chart_project_id"]).count 
          f.options[:xAxis][:categories] = [""]
        else
          # Agrupado por sprint
          data = chart.model.constantize.chart_performance.order("sequence").where("sprints.project_id = ?", chart.params["chart_project_id"]).group("sprints.sequence").count("tickets_sprints.id")
          data.collect do |sequence, qtd|    
            data_total << qtd
            categories << sequence
          end 
          
          data = chart.model.constantize.chart_performance.order("sequence").where("closed = true and project_id = ?", chart.params["chart_project_id"]).group("sprints.sequence").count("tickets_sprints.id") 
          data.collect do |sequence, qtd|   
            data_closed << qtd
          end 
          f.options[:xAxis][:categories] =  categories
        end
      end 
      #sprint atual
      if option == "2"
        data_total << chart.model.constantize.chart_performance.where("sprints.project_id = ? and sprint_id = ?", chart.params["chart_project_id"], chart.params["chart_sprint_id"]).count 
        data_closed << chart.model.constantize.chart_performance.where("closed = true and project_id = ? and sprint_id = ?", chart.params["chart_project_id"], chart.params["chart_sprint_id"]).count 
        f.options[:xAxis][:categories] = [""]
      end  
      
      # ultimos x sprint
      if option == "3"
        # Agrupado por sprint
        data = chart.model.constantize.chart_performance.limit(chart.params["chart_last_sprints"]).order("date_of_beginning desc, sequence").where("sprints.project_id = ?", chart.params["chart_project_id"]).group("date_of_beginning, sprints.sequence").count("tickets_sprints.id")
        puts data
        data.collect do |sequence, qtd|    
          data_total << qtd
          categories << sequence
        end 
        
        data = chart.model.constantize.chart_performance.limit(chart.params["chart_last_sprints"]).order("date_of_beginning, sequence").where("closed = true and project_id = ?", chart.params["chart_project_id"]).group("date_of_beginning, sprints.sequence").count("tickets_sprints.id") 
        data.collect do |sequence, qtd|   
          data_closed << qtd
        end 
        f.options[:xAxis][:categories] =  categories
      end
      f.series(:name=>'Total', :data=>data_total)    
      f.series(:name=>'Encerradas', :data=>data_closed)
    end
         
    
    graf
  end                                          
  
  
end
