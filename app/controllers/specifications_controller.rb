class SpecificationsController < ApplicationController       
  load_and_authorize_resource
  layout "bootstrap_full_content"
  # GET /specifications
  # GET /specifications.xml
  def index
    @specifications = Specification.search(params, current_user.account_id).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @specifications }
    end
  end

  # GET /specifications/1
  # GET /specifications/1.xml
  def show
    @specification = Specification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @specification }
    end
  end

  # GET /specifications/new
  # GET /specifications/new.xml
  def new
    @specification = Specification.new   
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @specification }                        
    end
  end

  # GET /specifications/1/edit
  def edit
    @specification = Specification.find(params[:id])
  end

  # POST /specifications
  # POST /specifications.xml
  def create
    @specification = Specification.new(params[:specification])
    @specification.account_id = current_user.account_id
    respond_to do |format|
      if @specification.save
        format.html { redirect_to(specification_specification_fields_path(@specification), :notice => 'Specification was successfully created.') }
        format.xml  { render :xml => @specification, :status => :created, :location => @specification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @specification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /specifications/1
  # PUT /specifications/1.xml
  def update
    @specification = Specification.find(params[:id])

    respond_to do |format|
      if @specification.update_attributes(params[:specification])
        format.html { redirect_to(@specification, :notice => 'Specification was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @specification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /specifications/1
  # DELETE /specifications/1.xml
  def destroy
    @specification = Specification.find(params[:id])
    @specification.destroy

    respond_to do |format|
      format.html { redirect_to(specifications_url) }
      format.xml  { head :ok }
    end
  end
end
