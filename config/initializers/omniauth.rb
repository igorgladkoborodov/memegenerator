Rails.application.config.middleware.use OmniAuth::Builder do
  provider :coub, ENV["COUB_KEY"], ENV["COUB_SECRET"], scope: "logged_in,create,like"
end
