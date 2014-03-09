class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :devise_parameter_sanitizer, if: :devise_controller?

  protected
  def devise_parameter_sanitizer
  	#devise_parameter_sanitizer.for(:sign_up){|u| u.permit(:name, :sex, 
  	#	:email, :password, :password_confirmation, :phone, :address, :motto, :occupation_id)}
	if resource_class == User
		User::ParameterSanitizer.new(User, :user, params)
	else
		super
	end	
  end

#  def after_sign_in_path_for(user)
  		#user_url(user)
#  end

 # def after_sign_out_path_for(user)
  #end
end
