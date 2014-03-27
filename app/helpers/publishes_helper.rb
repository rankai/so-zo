module PublishesHelper
	def get_default_state
		state = State.where(:name => "show").first
		state.id
	end
end
