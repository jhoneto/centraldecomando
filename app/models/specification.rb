class Specification < ActiveRecord::Base  
  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"     
  has_many :specification_fields, :class_name => "SpecificationField", :foreign_key => "specification_id"  
  
  validates_presence_of :project_id, :on => :create
  validates_presence_of :index, :on => :create
  validates_presence_of :title, :on => :create
  validates_presence_of :layout_id, :on => :create
  
  #before_create :set_layout
  after_create  :create_fields
  
  scope :with_project, lambda{|parameter| where("project_id = ?", parameter)}
  
  
  def self.search(parameters, account)
    ticket_query = self.scoped
    ticket_query =  ticket_query.where('account_id = ?', account)
    parameters.each do |parameter, value|
      if not value.empty? and ticket_query.respond_to? parameter
        ticket_query = ticket_query.send(parameter, value)
      end
    end
    ticket_query
  end         
  
  def set_layout         
    self.layout_id = self.project.layout_id
  end
  
  def create_fields        
    l = Layout.find(self.layout_id)
    l.layout_fields.each do |f|
      sf = SpecificationField.new
      sf.specification_id = self.id          
      sf.layout_field_id = f.id
      sf.label = f.label
      sf.field_type = f.field_type
      sf.order = f.order   
      sf.save
    end
  end
end
