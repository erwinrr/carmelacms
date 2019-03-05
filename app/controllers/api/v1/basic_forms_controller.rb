class Api::V1::BasicFormsController < ApplicationController
  def create
    @basic_form = BasicForm.new(service_form_params)
    respond_to do |format|
      if sales_form_check(@basic_form) && @basic_form.save 
        format.json {
          render json: {
            :result => "saved successfully"
          }
        }
      else
        format.json { render json: @basic_form.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def sales_form_check(bf)
    seller_picked = false;
    group = User.find(service_form_params[:user_id])&.groups&.first
    if bf.category == 'sales' && group
      new_salesmen = group.users.with_role(:sale_staff).where(form_attached: nil)
      salesmen = group.users.with_role(:sale_staff).order(:form_attached).where.not(form_attached:nil)
      if new_salesmen.any?
        bf.seller_id = new_salesmen.first.id
        new_salesmen.first.form_attached = DateTime.now
        new_salesmen.first.save
        seller_picked = true;
      end
      if salesmen.any? && !seller_picked
        bf.seller_id = salesmen.first.id
        salesmen.first.form_attached = DateTime.now
        salesmen.first.save
      end
    end
    return true
  end

  #params for the service form
  def service_form_params
    params.require(:basic_form).permit(:user_id, :category, data: [:make,
                                                                   :mileage,
                                                                   :model,
                                                                   :first_name,
                                                                   :last_name,
                                                                   :request,
                                                                   :vin,
                                                                   :year,
                                                                   :day,
                                                                   :time,
                                                                   :phone,
                                                                   :comments,
                                                                   :purpose])
  end

end