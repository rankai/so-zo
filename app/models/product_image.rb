class ProductImage < ActiveRecord::Base

	belongs_to :product

	#has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
	has_attached_file :product_image, 	     :styles => {:large =>"800x800>", :medium => "400x400>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"	
	#not set path for every user

	# skip for audio
	before_post_process :skip_for_audio

	validates_attachment_content_type 	:product_image, 	   :content_type => /\Aimage\/.*\Z/

	def skip_for_audio
		! %w(audio/ogg application/ogg).include?(product_image_content_type)
	end


	def make_image(name)
		#Dir.tmpdir
		file = File.join("#{name}")
		io = File.new(file)
		self.product_image = io
	end

end
