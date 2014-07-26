class UserParameterSanitizer  < Devise::ParameterSanitizer

	def sign_in
		default_params.permit(:email, :password, :remember_me)
	end


	def sign_up
		default_params.permit(:name, :sex, :email, :password, :password_confirmation, :phone, :address, :motto, :occupation_id, :description)
	end

	def account_update
		default_params.permit(:name, :email, :password, :password_confirmation, :current_password, :motto, :phone, :address, :sex, :occupation_id, :photo, :description)
	end
end