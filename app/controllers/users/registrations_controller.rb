class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with(resource) do |format|
          format.json { render json: {url: after_sign_up_path_for(resource)}, status: 200 }
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        #find_message is devise method. We used for json response
        msg = find_message(:"signed_up_but_#{resource.inactive_message}", {})
        expire_data_after_sign_in!
        respond_with(resource) do |format|
          format.json { render json: {message: msg,url: after_inactive_sign_up_path_for(resource)}, status: 200 }
        end
      end
    else
      clean_up_passwords resource
      msg = resource.errors.messages.values.each do |e|
        e
      end
       render json: {message: msg}, status: 401
    end
  end
end 