class TicketsController < ApplicationController
  layout "bootstrap_side_bar"
  before_filter :authorize
  # GET /tickets
  # GET /tickets.xml
  def index
    @tickets = Ticket.search(params, current_user.account_id).paginate(:page => params[:page])
    
    if request.xhr?      
      columns = ['id', 'title'] 
      render :json => json_for_jqgrid(@tickets, columns)
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @tickets }
      end
    end
  end

  # GET /tickets/1
  # GET /tickets/1.xml
  def show
    @ticket = Ticket.find(params[:id])
    
    @status = TicketStatus.get_next_status(@ticket, current_user.account_id)
    
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.xml
  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html {render :new , :layout => 'bootstrap_full_content'}# new.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  # POST /tickets.xml
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.user_registration_id = current_user.id
    @ticket.user_owner_id = current_user.id
    @ticket.account_id = current_user.account_id
    @ticket.date_of_registration = Time.now
    @ticket.ticket_status = TicketStatus.get_initial_status(current_user.account_id)
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to(@ticket, :notice => 'Ticket was successfully created.') }
        format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.xml
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to(@ticket, :notice => 'Ticket was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.xml
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to(tickets_url) }
      format.xml  { head :ok }
    end
  end
  
  def change_status
    ticket = Ticket.find_by_id(params[:id])
    ticket.update_attributes(:ticket_status_id => params[:status ])
    redirect_to(:controller => "tickets", :action => "show", :id => params[:id])
  end 
  
  def change_user_owner                   
    ticket = Ticket.find_by_id(params[:id])
    ticket.update_attributes(:user_owner_id => current_user.id)
    redirect_to(:controller => "tickets", :action => "show", :id => params[:id])
  end
end
