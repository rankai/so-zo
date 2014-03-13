class ProductTemplate < ActiveRecord::Base
	belongs_to :template_category

	#has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
	has_attached_file :front_image, 	 :styles => {:large =>"1000x1000>", :medium => "500x300>", :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :back_image,  	 :styles => {:large =>"1000x1000>", :medium => "500x300>", :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :side_image,  	 :styles => {:large =>"1000x1000>", :medium => "500x300>", :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :front_image_mask, :styles => {:large =>"1000x1000>", :medium => "500x300>", :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :back_image_mask,  :styles => {:large =>"1000x1000>", :medium => "500x300>", :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :side_image_mask,  :styles => {:large =>"1000x1000>", :medium => "500x300>", :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
	#not set path for every user

	# skip for audio
	before_post_process :skip_for_audio

	validates_attachment_content_type 	:front_image, :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:back_image,  :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:side_image,  :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:front_image_mask, :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:back_image_mask,  :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:side_image_mask,  :content_type => /\Aimage\/.*\Z/

	def skip_for_audio
		! %w(audio/ogg application/ogg).include?(front_image_content_type)
		! %w(audio/ogg application/ogg).include?(back_image_content_type)
		! %w(audio/ogg application/ogg).include?(side_image_content_type)
		! %w(audio/ogg application/ogg).include?(front_image_mask_content_type)
		! %w(audio/ogg application/ogg).include?(back_image_mask_content_type)
		! %w(audio/ogg application/ogg).include?(side_image_mask_content_type)
	end
end
