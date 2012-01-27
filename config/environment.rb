# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Centraldecomando::Application.initialize!

#Time::DATE_FORMATS[:data_br] = "%d/%m/%Y" 
Date::DATE_FORMATS.merge!(:default => "%d/%m/%Y")          
Time::DATE_FORMATS.merge!(:default => "%d/%m/%Y") 
#config.gem 'paperclip', :source => 'http://rubygems.org'
        

module ActionView
  module Helpers
    module DateHelper
      def select_weekday(date, options = {})
        week_options = []       
        date = Date.today if date.nil?
        date_holder = Date.today.cwday.day.ago
 
        0.upto(6) do |day|
          week_options << (((date.kind_of?(Fixnum) ? date : date.cwday) == day) ?
          %(<option value="#{day}" selected="selected">#{date_holder.strftime("%A")}</option>\n) :
          %(<option value="#{day}">#{date_holder.strftime("%A")}</option>\n)
          )
          date_holder = date_holder.to_date.next
        end
        select_html(options[:field_name] || 'weekday', week_options, options[:prefix], options[:include_blank], options[:discard_type], options[:disabled])
      end
    end
  end
end
