class ProductTemplate < ActiveRecord::Base

	belongs_to :template_category
	has_and_belongs_to_many :colors
	has_and_belongs_to_many :sizes

	#has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
	has_attached_file :head_image, 	     :styles => {:large =>"800x800>", :medium => "300x300>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :back_image,  	 :styles => {:large =>"800x800>", :medium => "300x300>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :side_image,  	 :styles => {:large =>"800x800>", :medium => "300x300>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :head_image_mask,  :styles => {:large =>"800x800>", :medium => "300x300>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :back_image_mask,  :styles => {:large =>"800x800>", :medium => "300x300>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :side_image_mask,  :styles => {:large =>"800x800>", :medium => "300x300>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
	#not set path for every user

	# skip for audio
	before_post_process :skip_for_audio

	validates_attachment_content_type 	:head_image, 	   :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:back_image,  	   :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:side_image,  	   :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:head_image_mask,  :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:back_image_mask,  :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type 	:side_image_mask,  :content_type => /\Aimage\/.*\Z/

	def skip_for_audio
		! %w(audio/ogg application/ogg).include?(head_image_content_type)
		! %w(audio/ogg application/ogg).include?(back_image_content_type)
		! %w(audio/ogg application/ogg).include?(side_image_content_type)
		! %w(audio/ogg application/ogg).include?(head_image_mask_content_type)
		! %w(audio/ogg application/ogg).include?(back_image_mask_content_type)
		! %w(audio/ogg application/ogg).include?(side_image_mask_content_type)
	end
end
