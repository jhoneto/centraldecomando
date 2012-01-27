class SpecificationField < ActiveRecord::Base
  
  belongs_to :specification, :class_name => "Specification", :foreign_key => "specification_id"      
  
  default_scope :order => '"order" asc'
  
  has_attached_file :value_image,	:url => "/images/specification/:id/:basename.:extension",
                                  :path => ":rails_root/public/images/specification/:id/:basename.:extension"
                            
end
