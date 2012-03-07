# encoding: UTF-8

class CcUsersController < ApplicationController
  #load_and_authorize_resource
  layout "bootstrap_full_content"
  before_filter :authorize
  
  def index
    @users = User.find_all_by_account_id(current_user.account_id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  # GET /projects/new
  # GET /projects/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /projects/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @user = User.new(params[:user])
    @user.account_id = current_user.account_id
    respond_to do |format|
      if @user.save
        format.html { redirect_to(cc_users_path, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(cc_users_path, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @user = Project.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(cc_users_path) }
      format.xml  { head :ok }
    end
  end   
  
  def alter_password    
    respond_to do |format| 
      if (params[:password_new] == params[:password_confirmation])   
        user = User.find(current_user.id)
        user.update_password(params[:password_new])
        format.html { redirect_to(home_path, :notice => 'Senha modificada com sucesso.') }
      else
        format.html { redirect_to(home_path, :alert => 'Nova senha não confere com a confirmação.') } 
      end                    
    end
  end
end
