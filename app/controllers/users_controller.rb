class UsersController < ApplicationController
	before_filter :authenticate_user!, only: [:update]

	def show
		if params[:user_id]
			@user = User.find(params[:user_id])
			p "get by user_id #{@user.id}"
		else
			@user = User.find(params[:id])
			p "get by id #{@user.id}"
		end
	end

	def publishes 
	end

	def products
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
		@user = User.find(params[:id])
		respond_to do |format|
	      if @user.update(params[:user].permit(:phone, :address))
	        format.html { redirect_to @user, notice: 'User was successfully updated.' }
	        format.json { render json: @user.to_json(:only => [:phone, :address])}
	      else
	        format.html { render action: 'edit' }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
	    end

	end
end

