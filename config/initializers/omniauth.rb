require 'openid/store/filesystem'
if Rails.env == "production"
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, 'oIdRcD6x1pwnC3aEm0TAHA', '8PWebacTPCMnDr5qpNgZRU2nhckOB6eejcoUIHS5K5w'
    provider :facebook, '216823235041994', 'cfd885f760c9b19edfc6a345f0ca892c'

    use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  end 
else
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, 'MWkQcgKXGjfHDFW12LrE7g', 'fuv4ynPU1klPyQZzzSNOhUxN5PW1gx5kerum1jsvtyk'
    provider :facebook, '210125529042474', 'ae3ef470ba50a122295d3eb72c0926ad'

    use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  end
end
