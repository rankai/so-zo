class Picture < ActiveRecord::Base
	belongs_to :album

	#has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
	has_attached_file :file, :styles => {:large => "800x800>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	#not set path for every user

	# skip for audio
	before_post_process :skip_for_audio

	validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

	def skip_for_audio
		! %w(audio/ogg application/ogg).include?(file_content_type)
	end

end
