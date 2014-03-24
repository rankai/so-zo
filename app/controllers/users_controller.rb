class UsersController < ApplicationController
	before_filter :authenticate_user!

	def show
		@user = User.find(params[:id])
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

