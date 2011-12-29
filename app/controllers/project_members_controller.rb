class ProjectMembersController < ApplicationController
  
  layout "bootstrap_full_content" 
  
  def index         
    @project = Project.find(params[:project_id])
    @project_members = @project.project_members.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_members}
    end
  end  
  
  def new 
    @project = Project.find(params[:project_id])
    @project_member = @project.project_members.build
  end 
  
  def edit       
    @project = Project.find(params[:project_id])
    @project_member = ProjectMember.find(params[:id])
  end 
  
  
  def create
    @project = Project.find(params[:project_id])
    @project_member = @project.project_members.build(params[:project_member])
    if @project_member.save
      flash[:notice] = "Successfully created project member."
      redirect_to project_project_members_path(@project)
    else
      render :action => 'new'
    end
  end 
  
  def update       
    @project = Project.find(params[:project_id]) 
    @project_member = ProjectMember.find(params[:id])
    if @project_member.update_attributes(params[:project_member])
      flash[:notice] = "Successfully updated project member."
      redirect_to project_project_members_path(@project)
    else
      render :action => 'edit'
    end 
  end 
  
  def destroy 
    @project = Project.find(params[:project_id])
    @project_member = ProjectMember.find(params[:id])
    @project_member.destroy
    flash[:notice] = "Successfully destroyed project member."
    redirect_to project_project_members_path(@project)
  end   
    
end
