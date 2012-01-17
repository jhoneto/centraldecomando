class CommentsController < ApplicationController
  
  def create        
    puts '%%%%%%%%%%%%%%%%'
    comment = Comment.new
    comment.comment_type = params[:comment_type]
    comment.process_id = params[:process_id]
    comment.comment = params[:comment]
    comment.user_id = current_user.id
    comment.save
    @id = comment.process_id 
  end 
  
  def destroy 
    comment = Comment.find(params[:id])
    @id = comment.process_id
    comment.destroy
  end
end
