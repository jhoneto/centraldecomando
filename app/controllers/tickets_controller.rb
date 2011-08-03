class TicketsController < ApplicationController
  layout "default"
  before_filter :authorize
  # GET /tickets
  # GET /tickets.xml
  def index
    @project_id = params[:project_id]
    @client_id = params[:client_id]
    @title = params[:title]
    @description = params[:description]
    @ticket_status_id = params[:ticket_status_id]
    @ticket_type_id = params[:ticket_type_id]
    
    @tickets = Ticket.get_tickets({
      :account_id => current_user.account_id,
      :project_id => params[:project_id],
      :client_id => params[:client_id],
      :title => params[:title],
      :description => params[:description],
      :ticket_status_id => params[:ticket_status_id],
      :ticket_type_id => params[:ticket_type_id]
    })
    

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @tickets }
    #end
  end

  # GET /tickets/1
  # GET /tickets/1.xml
  def show
    @ticket = Ticket.find(params[:id])

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
      format.html # new.html.erb
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
    @ticket.status = 1
    @ticket.user_registration_id = current_user.id
    @ticket.user_owner_id = current_user.id
    @ticket.account_id = current_user.account_id
    @ticket.ticket_type_id = 1
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
end
