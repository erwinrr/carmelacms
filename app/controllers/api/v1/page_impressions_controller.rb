class Api::V1::PageImpressionsController < ApplicationController
  def create
    slug = page_params[:slug]
    organization = current_user.organizations.first
    if organization.pages.exists?(slug: slug)
      @page = organization.pages.find_by(slug: slug)
    else
      @page = organization.pages.create(slug: slug, name: slug)
    end
    @page_impression = @page.page_impressions.new(page_impression_params)
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