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

  describe 'request_phase' do
    context 'no request params set and x_auth_access_type specified' do
      before do
        subject.options[:request_params] = nil
        subject.stub(:session).and_return(
          {'omniauth.params' => {'x_auth_access_type' => 'read'}})
        subject.stub(:old_request_phase).and_return(:whatever)
      end

      it 'should not break' do
        expect { subject.request_phase }.not_to raise_error
      end
    end
  end
end
