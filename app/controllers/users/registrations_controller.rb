class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  def create
    build_resource(sign_up_params)
    return render json: {message: [['Корисник со тој емаил веќе постои']]}, status: 401 if resource.exists_with_email?
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        render json: {}, status: 201
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        render json: {}, status: 201
      end
    else
      clean_up_passwords resource
      msg = resource.errors.messages.values.each{|e| e}
      render json: {message: msg}, status: 401
    end
  end
end 