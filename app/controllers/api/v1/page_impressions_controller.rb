class Api::V1::PageImpressionsController < ApplicationController
  def create
      @page = Page.find_by(slug: page_params[:slug])
      @page_impression = PageImpression.new(page_impression_params)
      @page_impression.page_id = @page.id
      respond_to do |format|
          if @page_impression.save
              format.json {
                  render json: {
                      :result => "Page Impression Saved!"
                  }
              }
          else
              format.json { render json: @basic_form.errors, status: :unprocessable_entity }
          end
      end
  end

  private
  def page_params
    params.require(:page).permit(:slug)
  end
  def page_impression_params
    params.require(:page_impression).permit(:user_id)
  end
end