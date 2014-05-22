module CollectionsHelper
	def already_collected(publish)
		if user_signed_in?
			count = Collection.where("collections.user_id = ? AND collections.publish_id = ?", current_user.id, publish.id).count
			if count > 0
				true
			else
				false
			end
		else
			false
		end
	end

	def my_collections()
		publishes = Publish.joins(:collections).where("collections.user_id = ?", current_user.id)
	end

	def relative_collection(publish)
		collection = Collection.find_by(publish_id: publish.id)
	end

end
