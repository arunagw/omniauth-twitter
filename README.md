# OmniAuth Twitter

This gem contains the Twitter strategy for OmniAuth.

Twitter uses the OAuth 1.0a flow, you can read about it here: https://dev.twitter.com/docs/auth/oauth

## How To Use It

Usage is as per any other OmniAuth 1.0 strategy. So let's say you're using Rails, you need to add the strategy to your `Gemfile`:

    gem 'omniauth-twitter'

You can pull them in directly from github e.g.:

    gem 'omniauth-twitter', :git => 'https://github.com/arunagw/omniauth-twitter.git'

Once these are in, you need to add the following to your `config/initializers/omniauth.rb`:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :twitter, "consumer_key", "consumer_secret" 
    end

You will obviously have to put in your key and secret, which you get when you register your app with Twitter (they call them API Key and Secret Key). 

Twitter also optionally supports specifying a username when authenticating. This is handy when your application supports multiple twitter accounts since you can prompt the user to login to the correct account (and not defaulting to the current login). 

To use this, just add a querystring for screen_name. 

	/auth/twitter?screen_name=scottw

You can also specify ```force_login``` without specifying the screen_name to prompt the user to choose the twitter account they wish to use.

    /auth/twitter?force_login=true

Twitter also optionally supports specifying a x_auth_access_type when authenticating. This is handy when you need to specify special permission in some cases.

To use this, just add a querystring for x_auth_access_type. 

	/auth/twitter?x_auth_access_type=read	


Now just follow the README at: https://github.com/intridea/omniauth

## Supported Rubies

OmniAuth Twitter is tested under 1.8.7, 1.9.2, 1.9.3 and Ruby Enterprise Edition.

[![CI Build
Status](https://secure.travis-ci.org/arunagw/omniauth-twitter.png)](http://travis-ci.org/arunagw/omniauth-twitter)

## Note on Patches/Pull Requests

- Fork the project.
- Make your feature addition or bug fix.
- Add tests for it. This is important so I don’t break it in a future version unintentionally.
- Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
- Send me a pull request. Bonus points for topic branches.

## License

Copyright (c) 2011 by Arun Agrawal

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.