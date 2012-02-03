class ProjectsController < ApplicationController
  layout "bootstrap_full_content"
  load_and_authorize_resource
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.where("account_id = ?", current_user.account_id).paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects}
      
      format.js do
        # What is the first line of the result set we want ? (due to pagination. 0 = first)
        offset = (params["page"].to_i-1)*params["rp"].to_i if params["page"] and params["rp"]

        # Conditions passed by flexigrid
        conditions = [params["qtype"]+"=?", params["query"]] if params["query"] and params["query"].strip!=""
        project = Project.where(conditions)

        # Total count of lines, before paginating
        total = project.count

        # People from the page
        project_per_page = project
        .order([params["sortname"], params["sortorder"]].join(" "))
        .offset(offset)
        .limit(params["rp"]).all

        # Juste an ugly trick to add a bouton (button) method to the class, to use it in the Flexigrid
        

        # Rendering
        render :json => {
          :rows=>project_per_page.collect{|r| {:id=>r.id, :cell=>[r.id, r.name]}}, 
          :page=>params["page"],
          :total=>total
          }.to_json

      end #format.js
    end
    
    
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    @project.account_id = current_user.account_id
    respond_to do |format|
      if @project.save
        format.html { redirect_to(projects_path, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new", :error => 'Erro' }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(projects_path, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
