class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
         #:confirmable, :lockable

  #validates :photo, :presence => true
  validates :name,  :presence => true
  validates :motto, :presence => true
  validates :sex,   :presence => true
  validates :occupation, :presence => true
  validates :password,   :presence => true, :confirmation => true, on: :create
  validates :password_confirmation, :presence => true, on: :create

  has_many    :orders, dependent: :destroy
  has_many    :publishes, dependent: :destroy
  has_many    :products, :through => :publishes, dependent: :destroy
  has_many    :collections, dependent: :destroy #dependent: :nullify
  has_many    :watches, dependent: :destroy
  #has_one     :income, dependent: :destroy
  #has_many :tags
  has_many    :credit_cards, dependent: :destroy
  belongs_to  :occupation
  has_and_belongs_to_many :tags

  #has_attached_file :file, :styles => {:detailed => "1920x1920>", :thumb => "100x100>"}
  has_attached_file :photo, :styles => { :medium => "197x197>", :thumb => "100x100>" }
  #not set path for every user

  # skip for audio
  before_post_process :skip_for_audio

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def skip_for_audio
    ! %w(audio/ogg application/ogg).include?(photo_content_type)
  end
end
