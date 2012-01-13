class LayoutFieldsController < ApplicationController       
  layout "bootstrap_po"
  # GET /layout_fields
  # GET /layout_fields.xml
  def index       
    @layout = Layout.find(params[:layout_id])
    @layout_fields = @layout.layout_fields.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @layout_fields }
    end
  end

  # GET /layout_fields/1
  # GET /layout_fields/1.xml
  def show
    @layout_field = LayoutField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @layout_field }
    end
  end

  # GET /layout_fields/new
  # GET /layout_fields/new.xml
  def new
    @layout = Layout.find(params[:layout_id])
    @layout_field = @layout.layout_fields.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @layout_field }
    end
  end

  # GET /layout_fields/1/edit
  def edit
    @layout = Layout.find(params[:layout_id])
    @layout_field = LayoutField.find(params[:id])
  end

  # POST /layout_fields
  # POST /layout_fields.xml
  def create                                 
    @layout = Layout.find(params[:layout_id])
    @layout_field = @layout.layout_fields.build(params[:layout_field])                   
    @layout_field.order = @layout.layout_fields.size
    respond_to do |format|
      if @layout_field.save
        format.html { redirect_to(layout_layout_fields_path, :notice => 'Layout field was successfully created.') }
        format.xml  { render :xml => @layout_field, :status => :created, :location => @layout_field }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @layout_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /layout_fields/1
  # PUT /layout_fields/1.xml
  def update
    @layout_field = LayoutField.find(params[:id])

    respond_to do |format|
      if @layout_field.update_attributes(params[:layout_field])
        format.html { redirect_to(@layout_field, :notice => 'Layout field was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @layout_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /layout_fields/1
  # DELETE /layout_fields/1.xml
  def destroy
    @layout_field = LayoutField.find(params[:id])
    l = Layout.find(@layout_field.layout_id)
    @layout_field.destroy              

    respond_to do |format|
      format.html { redirect_to(layout_layout_fields_url(l)) }
      format.xml  { head :ok }
    end
  end         
  
  def change_order
    field = LayoutField.find(params[:id])         
    order = field.order
    if params[:op] = '_up'
      other_field = LayoutField.find_by_layout_id_and_order(params[:layout_id], (field.order - 1))
    else                                                
      other_field = LayoutField.find_by_layout_id_and_order(params[:layout_id], (field.order + 1))
    end   
    
    field.order = other_field.order
    other_field.order = order
    
    field.save
    other_field.save           
    
    redirect_to(layout_layout_fields_path, :notice => 'Layout field was successfully created.')
  end
end
