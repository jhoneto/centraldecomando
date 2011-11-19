class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    @id = @comment.process_id
    @comment = Comment.new
  end 
  
  def destroy 
    @comment = Comment.find(params[:id])
    @id = @comment.id
    @comment.destroy
    @comment = Comment.new
  end
end
