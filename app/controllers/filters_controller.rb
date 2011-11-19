class FiltersController < ApplicationController
  layout "default"
  
  def index
    #@filter = Filter.find(2)
    #@result = @filter.model.constantize.search(@filter.where, current_user.account_id).paginate(:page => params[:page])
    #@columns = ['id', 'title']
    
    @filters = Filter.where("account_id = ?", current_user.account_id).paginate(:page => params[:page])
    
    if request.xhr?
      render :json => json_for_jqgrid(@result, @columns)
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @result }
      end
    end
    
  end
  
  
  def new
    @filter = Filter.new
    @where = nil

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @filter }
    end
  end
  
  # GET /projects/1/edit
  def edit
    @filter = Filter.find(params[:id])
    @where = @filter.where
    
    puts "***************************"
    puts @where
  end
  
  def create
    @filter = Filter.new(params[:filter])
    @filter.account_id = current_user.account_id
    @filter.user_id = current_user.id
    where = Hash.new
    columns = []
    params.each do |param, value|
      if  (param.include?('with_')) && (!value.nil?)
        where[param] = value
      end  
      
      if (param.include?('column_')) && (!value.nil?)
        columns << "#{value}"
      end
    end  
    
    @filter.where = where 
    @filter.columns = "'#{columns.join(",")}'"   
    
    respond_to do |format|
      if @filter.save
        format.html { redirect_to(filters_path, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @filter, :status => :created, :location => @filter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @filter.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  
  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @filter = Filter.find(params[:id])
    
    where = Hash.new
    params.each do |param, value|
      if  (param.include?('with_')) && (!value.nil?)
        where[param] = value
      end  
    end

    @filter.where = where

    respond_to do |format|
      if @filter.update_attributes(params[:filter])
        format.html { redirect_to(filters_path, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @filter.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def execute
    @filter = Filter.find(params[:id])
    @result = @filter.model.constantize.search(@filter.where, current_user.account_id).paginate(:page => params[:page])
    @columns = @filter.columns[1..-2].split(',')
    
    @resultado = json_for_jqgrid(@result, @columns)
    
    if request.xhr?
      render :json => @resultado
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @result }
      end
    end
    
  end
  
end
