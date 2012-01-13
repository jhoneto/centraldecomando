class SpecificationField < ActiveRecord::Base
  
  belongs_to :specification, :class_name => "Specification", :foreign_key => "specification_id"      
  
  default_scope :order => '"order" asc'
end
