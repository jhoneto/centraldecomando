class Story < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :as_a
  validates_presence_of :project_id
  validates_presence_of :i_want_to
  
  scope :with_project, lambda{|parameter| where("project_id = ?", parameter)}
  scope :with_i_want_to, lambda{|parameter| where("upper(i_want_to) like upper(?)", "%#{parameter}%")}
  
  def self.search(parameters, account)
    query = self.scoped
    query =  query.where('account_id = ?', account)
    parameters.each do |parameter, value|
      if not value.empty? and query.respond_to? parameter
        query = query.send(parameter, value)
      end
    end
    query
  end
  
end
