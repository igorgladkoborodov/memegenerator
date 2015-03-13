class User < ActiveRecord::Base
  API_URL = 'http://coub.com/api/v2/'

  has_many :coubs

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.auth_token = auth.credentials.token
      user.name = auth.extra.raw_info.name
    end
  end

  def client
    @_client ||= Faraday.new(url: API_URL, params: { access_token: auth_token })
  end
end
