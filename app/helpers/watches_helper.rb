module WatchesHelper
	def already_watched(user)
		if user_signed_in?
			count = Watch.where("watches.user_id = ? AND watches.watched_user_id = ?", current_user.id, user.id).count
			if count > 0
				true
			else
				false
			end
		else
			false
		end
	end



	def my_watches()
		watches = Watch.where("watches.user_id = ?", current_user.id)
	end

	def relative_user(user_id)
		user = User.find(user_id)
	end

end


