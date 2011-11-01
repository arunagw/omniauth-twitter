require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Twitter < OmniAuth::Strategies::OAuth2
      option :client_options, {:site => 'https://api.twitter.com'}

      def initialize(*args)
        super
        options.client_options[:authorize_path] = '/oauth/authenticate' if options.sign_in?
        options.authorize_params[:force_sign_in] = 'true' if options.force_sign_in?
      end

      def request_phase
        super
      end
      
      uid { access_token.params[:user_id] }

      info do
        {
          :nickname => raw_info['screen_name'],
          :name => raw_info['name'],
          :location => raw_info['location'],
          :image => raw_info['profile_image_url'],
          :description => raw_info['description'],
          :urls => {
            'Website' => raw_info['url'],
            'Twitter' => 'http://twitter.com/' + raw_info['screen_name'],
          }
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/1/account/verify_credentials.json').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end
OmniAuth.config.add_camelization 'twitter', 'Twitter'