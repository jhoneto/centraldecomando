class UserProfilesController < ApplicationController    
  load_and_authorize_resource
  layout "default"   
  
  def edit
    @user_profile = UserProfile.find_by_user_id(params[:id])
    if @user_profile.nil? 
      @user_profile = UserProfile.new
      @user_profile.user_id = params[:id] 
      @user_profile.save
    end                                 
    
  end   
  
  def update
    @user_profile = UserProfile.find(params[:id])

    respond_to do |format|
      if @user_profile.update_attributes(params[:user_profile])
        format.html { redirect_to(@user_profile, :notice => 'Story was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_profile.errors, :status => :unprocessable_entity }
      end
    end
  end
end
