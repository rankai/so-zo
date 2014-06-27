class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
  	identity = find_by(provider: auth.provider, uid: auth.id)
  	identity = create(uid: auth.uid, provider: auth.provider, url: auth.extra.raw_info.link) if identity.nil?
  	identity
  end
end
