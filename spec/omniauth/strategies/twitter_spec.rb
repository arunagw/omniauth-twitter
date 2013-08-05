require 'spec_helper'

describe OmniAuth::Strategies::Twitter do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  subject do
    args = ['appid', 'secret', @options || {}].compact
    OmniAuth::Strategies::Twitter.new(*args).tap do |strategy|
      strategy.stub(:request) {
        request
      }
    end
  end

  describe 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('twitter')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://api.twitter.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_path).to eq('/oauth/authenticate')
    end
  end

  describe 'image_size option' do
    context 'when user has an image' do
      it 'should return image with size specified' do
        @options = { :image_size => 'original' }
        subject.stub(:raw_info).and_return(
          { 'profile_image_url' => 'http://twimg0-a.akamaihd.net/sticky/default_profile_images/default_profile_0_normal.png' }
        )
        expect(subject.info[:image]).to eq('http://twimg0-a.akamaihd.net/sticky/default_profile_images/default_profile_0.png')
      end

      it 'should return secure image with size specified' do
        @options = { :secure_image_url => 'true', :image_size => 'mini' }
        subject.stub(:raw_info).and_return(
          { 'profile_image_url_https' => 'https://twimg0-a.akamaihd.net/sticky/default_profile_images/default_profile_0_normal.png' }
        )
        expect(subject.info[:image]).to eq('https://twimg0-a.akamaihd.net/sticky/default_profile_images/default_profile_0_mini.png')
      end

      it 'should return normal image by default' do
        subject.stub(:raw_info).and_return(
          { 'profile_image_url' => 'http://twimg0-a.akamaihd.net/sticky/default_profile_images/default_profile_0_normal.png' }
        )
        expect(subject.info[:image]).to eq('http://twimg0-a.akamaihd.net/sticky/default_profile_images/default_profile_0_normal.png')
      end
    end
  end

  describe 'request_phase' do
    context 'with no request params set and x_auth_access_type specified' do
      before do
        subject.stub(:request).and_return(
          double('Request', {:params => {'x_auth_access_type' => 'read'}})
        )
        subject.stub(:old_request_phase).and_return(:whatever)
      end

      it 'should not break' do
        expect { subject.request_phase }.not_to raise_error
      end
    end
  end
end
