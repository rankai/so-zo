class UsersController < ApplicationController
	before_filter :authenticate_user!, only: [:update]
	# if enable this, update(json request) won't work because the request would be filtered chained  
	# before_action :set_user, :finish_signup

	def show
		if params[:user_id]
			@user = User.find(params[:user_id])
			p "get by user_id #{@user.id}"
		else
			@user = User.find(params[:id])
			p "get by id #{@user.id}"
		end
	end

	def watch
		@user = User.find(params[:user_id])
		@watch = current_user.watches.build()
		@watch.watched_user_id = @user.id
		@watch.save
		respond_to do |format|
			format.html {redirect_to user_watches_path(current_user), notice: t("flash.notices.watch_added")}
		end
	end

	def update
		p "tries to update"
		respond_to do |format|
	      if current_user.update(user_params)
	      	format.json { render json: current_user.to_json(:only => [:phone, :address])}
	        format.html { redirect_to current_user }
	      else
	        format.html { render action: 'edit' }
	        format.json { render json: current_user.errors, status: :unprocessable_entity }
	      end
	    end

	end

	def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if current_user.update(user_params)
        current_user.skip_reconfirmation!
        sign_in(current_user, :bypass => true)
        #redirect_to current_user, notice: 'Your profile was successfully updated.'
        redirect_to current_user, notice: t('devise.updates.updated')
      else
        @show_errors = true
      end
    end
  end
  
  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email, :photo, :phone, :address, :occupation, :sex, :description, :current_password ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end

end

