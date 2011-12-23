# encoding: UTF-8

class SprintsController < ApplicationController
  layout "bootstrap_full_content"
  # GET /sprints
  # GET /sprints.xml
  def index
    
    if params[:project_id].nil?
      @project = Project.find(session[:project])
    else
      @project = Project.find(params[:project_id])
    end
    
    @sprints = Sprint.where("project_id = ?", @project.id).paginate(:page => params[:page], :per_page => 10)
    session[:project] = @project.id
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sprints }
    end
  end

  # GET /sprints/1
  # GET /sprints/1.xml
  def show
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/new
  # GET /sprints/new.xml
  def new
    @sprint = Sprint.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/1/edit
  def edit
    @sprint = Sprint.find(params[:id])
  end

  # POST /sprints
  # POST /sprints.xml
  def create
    @sprint = Sprint.new(params[:sprint])
    @sprint.project_id = session[:project]
    @sprint.status = 1 #Aberto

    respond_to do |format|
      if @sprint.save
        format.html { redirect_to(sprints_path, :notice => 'Sprint was successfully created.') }
        format.xml  { render :xml => @sprint, :status => :created, :location => @sprint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sprints/1
  # PUT /sprints/1.xml
  def update
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        format.html { redirect_to(@sprint, :notice => 'Sprint was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sprints/1
  # DELETE /sprints/1.xml
  def destroy
    @sprint = Sprint.find(params[:id])
    @sprint.destroy

    respond_to do |format|
      format.html { redirect_to(sprints_url) }
      format.xml  { head :ok }
    end
  end  
  
  
  def close 
    @sprint = Sprint.find(params[:id]) 
   
     
    respond_to do |format| 
      if @sprint.close == true          
        format.html { redirect_to(sprints_url, :notice => 'Sprint encerrado com sucesso.') }
        format.xml  { head :ok } 
      else               
        format.html { redirect_to(sprints_url, :alert => 'Sprint não pode ser encerrado.') }
        format.xml  { head :ok }
      end
    end
  end   
  
  
  def combo_sprints
    sprints = Sprint.where("project_id = ?", params[:project_id]).paginate(:page => params[:page], :per_page => 10) 
    render :partial => "combo_sprints", :locals => { :sprints => sprints } 
  end
  
  
  
  
end
