module PublishesHelper
	def get_default_state
		state = State.find_by(name: "show")
		state.id
	end

	def author_works(user,count)
		total_publishes(user).limit(count)
	end
end
