class RegistrationsController < Devise::RegistrationsController
  

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
end

    resource_updated = @user.update_attributes(account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      #respond_with resource, location: after_update_path_for(resource)
      redirect_to :root
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end



  
end