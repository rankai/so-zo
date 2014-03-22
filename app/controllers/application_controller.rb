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

  #--------------- error handler ------------------# 
  def self.rescue_errors
    rescue_from Exception, :with => :render_error
    rescue_from RuntimeError, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from ActionController::UnknownAction, :with => :render_not_found
  end

  rescue_errors unless Rails.env.development?

  def render_not_found(exception = nil)
    render :file => "/public/404.html", :status => 404
  end

  def render_error(exception = nil)
    render :file => "/public/500.html", :status => 500
  end

  #--------------- error handler ------------------#


  #---------------- cart handler ------------------#

  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
 
  #---------------- cart handler ------------------#

end
