class User < ActiveRecord::Base
  rolify

  TEMP_EMAIL_PREEFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, 
         :omniauthable, :timeoutable, :confirmable, :lockable

  #validates :photo, :presence => true
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates :name,  :presence => true
  validates :motto, :presence => true
  validates :description, :presence => true
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
  has_attached_file :photo, :styles => { :medium => "197x197>", :thumb => "100x100>" }, :default_url => "images/question_mark.jpg"
  #not set path for every user

  # skip for audio
  before_post_process :skip_for_audio

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def skip_for_audio
    ! %w(audio/ogg application/ogg).include?(photo_content_type)
  end

  def self.find_for_oauth(auth, signed_in_resource = nil, placeholder)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        password = "Devise.friendly_token[0,20]"
        @occupation = Occupation.first
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: password,
          password_confirmation: password,
          motto: placeholder,
          description: placeholder,
          sex: auth.extra.raw_info.gender,
          occupation: @occupation,
          photo: open(auth[:info][:image])
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.update(:user => user)
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def make_image(name)
    #Dir.tmpdir
    file = File.join("#{name}")
    io = File.new(file)
    self.photo = io
  end

end
