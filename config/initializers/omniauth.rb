require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'MWkQcgKXGjfHDFW12LrE7g', 'fuv4ynPU1klPyQZzzSNOhUxN5PW1gx5kerum1jsvtyk'
  provider :facebook, '210125529042474', 'ae3ef470ba50a122295d3eb72c0926ad'

  use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end

