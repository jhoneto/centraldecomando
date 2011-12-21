class HomeController < ApplicationController
  layout "bootstrap_side_bar"
  before_filter :authorize
  
  def index    
    @h = LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = "bar"
        f.options[:subtitle][:text] = "Por atividades"     
        f.options[:title][:text] = "Por atividades"        
        f.options[:xAxis][:categories] = ['Abertas', 'Em Andamento', 'Concluidas']      
        f.series(:name=>'Minhas', :data=>[10, 2, 100])    
        f.series(:name=>'Geral', :data=>[115, 20, 150])
      end
      
  end
end
