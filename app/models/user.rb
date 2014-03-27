class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many    :orders
  has_many    :publishes
  #has_many :tags
  has_many    :credit_cards
  belongs_to  :occupation
  has_and_belongs_to_many :tags

  #has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
  has_attached_file :photo, :styles => { :medium => "197x197>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  #not set path for every user

  # skip for audio
  before_post_process :skip_for_audio

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def skip_for_audio
    ! %w(audio/ogg application/ogg).include?(photo_content_type)
  end
end
