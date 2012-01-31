# encoding: UTF-8

class SpecificationFieldsController < ApplicationController   
  layout "bootstrap_full_content"
  # GET /specification_fields
  # GET /specification_fields.xml
  def index           
    @specification = Specification.find(params[:specification_id])
    @specification_fields = @specification.specification_fields

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @specification_fields }
    end
  end

  # GET /specification_fields/1
  # GET /specification_fields/1.xml
  def show
    @specification_field = SpecificationField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @specification_field }
    end
  end

  # GET /specification_fields/new
  # GET /specification_fields/new.xml
  def new
    @specification_field = SpecificationField.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @specification_field }
    end
  end

  # GET /specification_fields/1/edit
  def edit
    @specification_field = SpecificationField.find(params[:id])
  end

  # POST /specification_fields
  # POST /specification_fields.xml
  def create
   puts "%%%%%%%%%%%%%%%%%%%"        
   
   params.each do |parameter, value|
     if parameter.include?('field_')
       field = SpecificationField.find_by_id(parameter[6..-1])
       case field.field_type
       when FieldType::TEXT
         field.value_text = value
       when FieldType::MEMO
         field.value_memo = value
       when FieldType::DATE
         field.value_date = value
       when FieldType::IMAGE
         puts "************"
         puts value
         field.value_image = File.new(value)   
       end
       field.save
     end
   end
   
   redirect_to(specifications_path, :notice => 'Especificação salva com sucesso.')
  end

  # PUT /specification_fields/1
  # PUT /specification_fields/1.xml
  def update            
    puts "$$$$$$$$"    
    @specification = Specification.find(params[:specification_id])
    @specification_field = SpecificationField.find(params[:id])

    respond_to do |format|
      if @specification_field.update_attributes(params[:specification_field])
        format.html { redirect_to(specification_specification_fields_path(@specification)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @specification_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /specification_fields/1
  # DELETE /specification_fields/1.xml
  def destroy
    @specification_field = SpecificationField.find(params[:id])
    @specification_field.destroy

    respond_to do |format|
      format.html { redirect_to(specification_fields_url) }
      format.xml  { head :ok }
    end
  end
end
