require 'spec_helper'

describe OmniAuth::Strategies::Twitter do
  
  it 'should give the right options' do
    some_rack_app = double('app').as_null_object
    OmniAuth::Strategies::Twitter.new(some_rack_app).name.should == 'twitter'
  end

end
