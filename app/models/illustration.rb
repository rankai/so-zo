class Illustration < ActiveRecord::Base
	belongs_to :user
	#has_many  :tags
	has_many   :products 

	#has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
	has_attached_file :ill_image, :styles => {:large => "1000x1000>", :medium => "500x500>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
	#not set path for every user

	# skip for audio
	before_post_process :skip_for_audio

	validates_attachment_content_type :ill_image, :content_type => /\Aimage\/.*\Z/

	def skip_for_audio
		! %w(audio/ogg application/ogg).include?(ill_image_content_type)
	end
end
