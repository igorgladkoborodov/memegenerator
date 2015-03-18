class User < ActiveRecord::Base
  has_many :coubs

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.auth_token = auth.credentials.token
      user.name = auth.extra.raw_info.name
      user.save!
    end
  end

  def client
    @client ||= Faraday.new(:url => "http://coub.com/api/v2/", :params => {:access_token => auth_token})
  end

end
