class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  #validates :photo, :presence => true
  validates :name,  :presence => true
  validates :motto, :presence => true
  validates :sex,   :presence => true
  validates :occupation, :presence => true
  validates :password,   :presence => true, :confirmation => true, on: :create
  validates :password_confirmation, :presence => true, on: :create

  has_many    :orders
  has_many    :publishes
  has_many    :products, :through => :publishes
  #has_many :tags
  has_many    :credit_cards
  belongs_to  :occupation
  has_and_belongs_to_many :tags

  #has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
  has_attached_file :photo, :styles => { :medium => "197x197>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  #not set path for every user
  before_create :randomize_file_name  
      
  private  
  def randomize_file_name  
      #archives 就是你在 has_attached_file :archives 使用的名字  
      extension = File.extname(photo_file_name).downcase  
     #你可以改成你想要的文件名，把下面这个方法的第二个参数随便改了就可以了。  
      self.photo.instance_write(:file_name, "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")  
  end  

  # skip for audio
  before_post_process :skip_for_audio

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def skip_for_audio
    ! %w(audio/ogg application/ogg).include?(photo_content_type)
  end
end
