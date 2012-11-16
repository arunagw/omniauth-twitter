require 'spec_helper'

describe OmniAuth::Strategies::Twitter do
  subject do
    OmniAuth::Strategies::Twitter.new({})
  end

  context 'client options' do
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
end
