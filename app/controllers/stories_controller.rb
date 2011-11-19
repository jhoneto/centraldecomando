class StoriesController < ApplicationController
  
  layout "default"
  # GET /stories
  # GET /stories.xml
  def index
    @columns = ['id', 'as_a', 'i_want_to', 'complexity', 'priority']
    @stories = Story.search(params, current_user.account_id).paginate(:page => params[:page])
    
    if request.xhr?
      render :json => json_for_jqgrid(@stories, @columns)
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @stories }
      end
    end
    
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.xml
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  # POST /stories.xml
  def create
    @story = Story.new(params[:story])
    @story.account_id = current_user.account_id

    respond_to do |format|
      if @story.save
        format.html { redirect_to(@story, :notice => 'Story was successfully created.') }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to(@story, :notice => 'Story was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(stories_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
    puts 'aqui'
    @columns = ['id', 'as_a', 'i_want_to', 'complexity', 'priority']
    @stories = Story.paginate(:page => params[:page], :per_page => params[:rows])
    if request.xhr?
      render :json => json_for_jqgrid(@stories, @columns)
    end
  end
end
