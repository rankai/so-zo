class Picture < ActiveRecord::Base
	belongs_to :album

	#has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
	has_attached_file :file, :styles => {:large => "800x800>", :medium => "300x300>", :thumb => "100x100>" }#, :default_url => "/images/:style/missing.png"
	#not set path for every user
	before_create :randomize_file_name  
      
	private  
	def randomize_file_name  
	    #archives 就是你在 has_attached_file :archives 使用的名字  
	    extension = File.extname(file_file_name).downcase  
	   #你可以改成你想要的文件名，把下面这个方法的第二个参数随便改了就可以了。  
	    self.file.instance_write(:file_name, "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")  
	end  

	# skip for audio
	before_post_process :skip_for_audio

	validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

	def skip_for_audio
		! %w(audio/ogg application/ogg).include?(file_content_type)
	end

end
