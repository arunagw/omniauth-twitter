require 'omniauth-oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class Twitter < OmniAuth::Strategies::OAuth
      option :name, 'twitter'
      option :client_options, {:authorize_path => '/oauth/authenticate',
                               :site => 'https://api.twitter.com',
                               :proxy => ENV['http_proxy'] ? URI(ENV['http_proxy']) : nil}

      uid { access_token.params[:user_id] }

      info do
        {
          :nickname => raw_info['screen_name'],
          :name => raw_info['name'],
          :location => raw_info['location'],
          :image => options[:secure_image_url] ? raw_info['profile_image_url_https'] : raw_info['profile_image_url'],
          :description => raw_info['description'],
          :urls => {
            'Website' => raw_info['url'],
            'Twitter' => "https://twitter.com/#{raw_info['screen_name']}",
          }
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        @raw_info ||= MultiJson.load(access_token.get('/1.1/account/verify_credentials.json?include_entities=false&skip_status=true').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      alias :old_request_phase :request_phase

      def request_phase
        force_login = session['omniauth.params'] ? session['omniauth.params']['force_login'] : nil
        screen_name = session['omniauth.params'] ? session['omniauth.params']['screen_name'] : nil
        x_auth_access_type = session['omniauth.params'] ? session['omniauth.params']['x_auth_access_type'] : nil
        if force_login && !force_login.empty?
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:force_login => 'true')
        end
        if screen_name && !screen_name.empty?
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:force_login => 'true', :screen_name => screen_name)
        end
        if x_auth_access_type
          options[:request_params] ||= {}
          options[:request_params].merge!(:x_auth_access_type => x_auth_access_type)
        end

        if session['omniauth.params'] && session['omniauth.params']["use_authorize"] == "true"
          options.client_options.authorize_path = '/oauth/authorize'
        else
          options.client_options.authorize_path = '/oauth/authenticate'
        end

        old_request_phase
      end

    end
  end
end
