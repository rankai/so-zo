class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product


	has_attached_file :product_image, :styles => {:thumb => "100x100>" }	
	#not set path for every user

	# skip for audio
	before_post_process :skip_for_audio

	validates_attachment_content_type 	:product_image, 	   :content_type => /\Aimage\/.*\Z/

	def skip_for_audio
		! %w(audio/ogg application/ogg).include?(product_image_content_type)
	end


	public
	def make_image(name)
		#Dir.tmpdir
		file = File.join("#{name}")
		io = File.new(file)
		self.product_image = io
	end
end
