class Priority < ActiveRecord::Base                                  
  
#  has_attached_file :icon, 
#                     :styles => { :medium => "300x300>",
#                                  :thumb => "100x100>" }       
                                  
  has_attached_file :icon,	:url => "/images/priority/:id/:basename.:extension",
                            :path => ":rails_root/public/images/priority/:id/:basename.:extension"
end
