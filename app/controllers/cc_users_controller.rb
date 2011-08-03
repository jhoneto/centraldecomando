class CcUsersController < ApplicationController
  layout "default"
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
end
