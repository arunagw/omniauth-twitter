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
          :image => image_url,
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
        %w[force_login lang screen_name].each do |v|
          if request.params[v]
            options[:authorize_params][v.to_sym] = request.params[v]
          end
        end

        %w[x_auth_access_type].each do |v|
          if request.params[v]
            options[:request_params][v.to_sym] = request.params[v]
          end
        end

        if request.params['use_authorize'] == 'true'
          options[:client_options][:authorize_path] = '/oauth/authorize'
        else
          options[:client_options][:authorize_path] = '/oauth/authenticate'
        end

        old_request_phase
      end

      private

      def image_url
        original_url = options[:secure_image_url] ? raw_info['profile_image_url_https'] : raw_info['profile_image_url']
        case options[:image_size]
        when 'mini'
          original_url.sub('normal', 'mini')
        when 'bigger'
          original_url.sub('normal', 'bigger')
        when 'original'
          original_url.sub('_normal', '')
        else
          original_url
        end
      end

    end
  end
end
