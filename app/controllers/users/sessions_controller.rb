class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if !session[:return_to].blank?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
