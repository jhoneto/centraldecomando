class LayoutField < ActiveRecord::Base
  
  belongs_to :layout, :class_name => "Layout", :foreign_key => "layout_id"  
  
  after_destroy :reorder  
  
  default_scope :order => '"order" ASC'           
  
  def reorder
    l = Layout.find(self.layout_id)     
    i = 1
    l.layout_fields.each do |lf|
      lf.order = i
      lf.save
      i = i + 1
    end
  end
end
