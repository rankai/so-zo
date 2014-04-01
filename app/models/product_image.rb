class ProductImage < ActiveRecord::Base

	belongs_to :product

	#has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
	#, :default_url => "/assets/:style/missing.png"
	has_attached_file :product_image, 	:styles => {:large =>"800x800>", :medium => "400x400>", :thumb => "100x100>" }	
	#not set path for every user
	before_create :randomize_file_name  
      
	private  
	def randomize_file_name  
	    #archives 就是你在 has_attached_file :archives 使用的名字  
	    extension = File.extname(product_image_file_name).downcase  
	   #你可以改成你想要的文件名，把下面这个方法的第二个参数随便改了就可以了。  
	    self.product_image.instance_write(:file_name, "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")  
	end  

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
