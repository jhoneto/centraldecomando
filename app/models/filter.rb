class Filter < ActiveRecord::Base
  serialize :where
  #serialize :columns
end
