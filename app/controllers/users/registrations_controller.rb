# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    # email がパラメータにある場合
    if !params[:email].nil?
      @email = params[:email]
    end
    # 招待先の lab がある場合
    if !params[:invited_lab_id].nil?
      @invited_lab_id = params[:invited_lab_id]
    end
    super
  end

  # POST /resource
  # source: https://github.com/plataformatec/devise/blob/master/app/controllers/devise/registrations_controller.rb
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        # 研究室招待を伴う場合
        lab = Lab.find_by(id: params[:invited_lab_id])
        lab_user = invite_lab(resource, lab.id) if !lab.nil?
        if lab_user.nil?
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          redirect_to invites_complete_lab_url(lab) and return
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def invite_lab(user, invited_lab_id)
    # ユーザ再取得
    user = User.find_by(email: user.email)
    lab = Lab.find(invited_lab_id)
    one_time_token = OneTimeToken.find_by(mail_address: user.email)
    # nil チェック
    lab_user = LabUser.new({user_id: user.id, lab_id: lab.id})
    if lab_user.save
      one_time_token.destroy
      return lab_user
    else
      return nil
    end
  end
end
