class CommentsController < ApplicationController
  before_action :set_movie, only: :create
  before_action :find_and_authorize_comment, except: :create

  def create
    @commentable = @movie
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @movie, notice: "Comment created successfully"
    else
      redirect_to @movie, alert: "Failed to create comment"
      flash[:error] = @comment.errors.full_messages.join(', ')
    end
  end

  def edit
  end

  def update
    @comment.assign_attributes(comment_params)
    if @comment.save
      redirect_to @comment.commentable, notice: "Comment updated successfully"
    else
      flash[:allert] = @comment.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: 'Comment was successfully deleted.'
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def find_and_authorize_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end
end