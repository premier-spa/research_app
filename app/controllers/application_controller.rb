class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:type, :description, :image, :first_name, :last_name, :self_promotion, :skill, :quolification, :internship, :grade, :theme, :abstract, :pat_time_job, :industry_id, :prefecture_id, :occupation_id, :job_hunting_status])
    devise_parameter_sanitizer.permit(:account_update, keys: [:type, :description, :image, :first_name, :last_name, :self_promotion, :skill, :quolification, :internship, :grade, :theme, :abstract, :pat_time_job, :industry_id, :prefecture_id, :occupation_id, :job_hunting_status])
  end
end
