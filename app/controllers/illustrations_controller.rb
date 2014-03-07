class IllustrationsController < ApplicationController
	def index
		#@illstrations = Illstration.all
	end

	def create
		@illstration = Illstration.new(params[:illstration])
		if @illstration.save
			redirect_to @illstration
		else
			render 'new'
		end
	end

	def edit
		@illstration = Illstration.find(params[:id])

		if @illstration.update(params[:illstration].permit(:name, :description))
			redirect_to @illstration
		else
			render 'edit'
		end
	end

	def show
		@illstration = Illstration.find(params[:id])
	end

	def destroy
		@illstration = Illstration.find(params[:id])
		@illstration.destroy

		redirect_to illstrations_path
	end

end
