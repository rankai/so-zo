class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :devise_parameter_sanitizer, if: :devise_controller?


  # cancan exception handle
  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to main_app.root_url, :alert => exception.message
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end

  # devise parameter sanitizer(strong parameters)
  protected
  def devise_parameter_sanitizer
  	#devise_parameter_sanitizer.for(:sign_up){|u| u.permit(:name, :sex, 
  	#	:email, :password, :password_confirmation, :phone, :address, :motto, :occupation_id)}
	if resource_class == User
		UserParameterSanitizer .new(User, :user, params)
	else
		super
	end	
  end

#  def after_sign_in_path_for(user)
  		#user_url(user)
#  end

 # def after_sign_out_path_for(user)
  #end

  def after_sign_in_path_for(resource)
       #if resource.is_a?(User)
         #if User.count == 1
        #   resource.add_role 'admin'
         #end
         #resource
       #end
       root_path
  end
end
