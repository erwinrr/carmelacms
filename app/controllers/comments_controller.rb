class CommentsController < ApplicationController
  def new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @basic_form = BasicForm.find(comment_params[:basic_form_id])
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to organization_basic_form_path(@organization, @basic_form) }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end

  private 
  def comment_params
    params.require(:comment).permit(:text, :user_id, :basic_form_id)
  end
end
