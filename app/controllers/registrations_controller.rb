class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  # before_filter :configure_account_update_params, only: [:update]

  def new
    super do |resource|
      resource.account_type = @account_type
      resource.build_account({})
    end
  end

  def new_guest
    @account_type = "Guest"
    new
  end

  def new_shop_owner
    @account_type = "ShopOwner"
    new
  end

  def new_admin
    @account_type = "Admin"
    new
  end

  def create
    @account_type = sign_up_params[:account_type]
    super
  end

  def edit
    render :"edit_#{current_user.account.class.name.downcase}"
  end

  def update
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def respond_with(*resources, &block)
    if resource.errors.empty?
      super
    elsif action_name == "create"
      render :"new_#{resource.account_type.downcase}"
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    account_attributes = {
      account_attributes: [:name, :firstname, :lastname, :birthdate, :avatar,
                           :photo, :shop_name] }
    extras = [:account_type, account_attributes]
    extras.each { |atr| devise_parameter_sanitizer.for(:sign_up) << atr }
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
