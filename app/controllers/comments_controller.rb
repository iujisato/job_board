class CommentsController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    @comment = @job.comments.build(params[:comment].permit!)

    respond_to do |format|
      format.html do
        if @comment.save
          flash[:success] = "Comment was created with success!"
        else
          flash[:danger] = "Fill all fields to create a comment."
        end
        redirect_to @job
      end
      format.js do
        @comment.save
      end
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment was deleted with success!"
    redirect_to @comment.job
  end
end

 