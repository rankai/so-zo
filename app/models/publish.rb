class Publish < ActiveRecord::Base

	# validations
	validates :name, presence: true, length: {minimum: 1, maximum: 10}
	validates :description, presence: true, length: {minimum: 5, maximum: 100}
	validates :publish_image, presence: true
	validates :isOriginal, presence: true

	belongs_to :user
	belongs_to :state
	#has_many  :tags
	has_many   :products, dependent: :destroy
	has_many   :product_images, :through => :products
	has_many   :line_items, :through => :products
	has_many   :collections, dependent: :destroy
	belongs_to :publish_category

	#has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
	has_attached_file :publish_image, :styles => {:large => "1280x800>", :medium => "640x400>", :thumb => "160x100>" }
	#not set path for every user
	before_create :randomize_file_name 

      
	private  
	def randomize_file_name  
	    #archives 就是你在 has_attached_file :archives 使用的名字  
	    extension = File.extname(publish_image_file_name).downcase  
	   #你可以改成你想要的文件名，把下面这个方法的第二个参数随便改了就可以了。  
	    self.publish_image.instance_write(:file_name, "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")  
	end  
	

	# skip for audio
	before_post_process :skip_for_audio

	validates_attachment_content_type :publish_image, :content_type => /\Aimage\/.*\Z/

	def skip_for_audio
		! %w(audio/ogg application/ogg).include?(publish_image_content_type)
	end

end
