# OmniAuth Twitter

This gem contains the Twitter strategy for OmniAuth.

Twitter offers a few different methods of integration. This strategy implements the browser variant of the "[Sign in with Twitter](https://dev.twitter.com/docs/auth/implementing-sign-twitter)" flow.

Twitter uses OAuth 1.0a. Twitter's developer area contains ample documentation on how it implements this, so if you are really interested in the details, go check that out for more.

## Before You Begin

You should have already installed OmniAuth into your app; if not, read the [OmniAuth README](https://github.com/intridea/omniauth) to get started.

Now sign in into the [Twitter developer area](http://dev.twitter.com) and create an application. Take note of your Consumer Key and Consumer Secret (not the Access Token and Secret) because that is what your web application will use to authenticate against the Twitter API. Make sure to set a callback URL or else you may get authentication errors. (It doesn't matter what it is, just that it is set.)

## Using This Strategy

First start by adding this gem to your Gemfile:

    gem 'omniauth-twitter'

If you need to use the latest HEAD version, you can do so with:

    gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'

Next, tell OmniAuth about this provider. For a Rails app, your `config/initializers/omniauth.rb` file should look like this:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :twitter, "CONSUMER_KEY", "CONSUMER_SECRET"
    end

Replace CONSUMER_KEY and CONSUMER_SECRET with the appropriate values you obtained from dev.twitter.com earlier.

## Authentication Options

Twitter supports a [few options](https://dev.twitter.com/docs/api/1/get/oauth/authenticate) when authenticating. Usually you would specify these options as query parameters to the Twitter API authentication url (`https://api.twitter.com/oauth/authenticate` by default). With OmniAuth, of course, you use `http://yourapp.com/auth/twitter` instead. Because of this, this OmniAuth provider will pick up the query parameters you pass to the `/auth/twitter` URL and re-use them when making the call to the Twitter API.

The options are:

* **force_login** - This option sends the user to a sign-in screen to enter their Twitter credentials, even if they are already signed in. This is handy when your application supports multiple Twitter accounts and you want to ensure the correct user is signed in. *Example:* `http://yoursite.com/auth/twitter?force_login=true`

* **screen_name** - This option implies **force_login**, except the screen name field is pre-filled with a particular value. *Example:* `http://yoursite.com/auth/twitter?screen_name=jim`

* **x_auth_access_type** - This option (described [here](https://dev.twitter.com/docs/api/1/post/oauth/request_token)) lets you request the level of access that your app will have to the Twitter account in question. *Example:* `http://yoursite.com/auth/twitter?x_auth_access_type=read`

* **use_authorize** - There are actually two URLs you can use against the Twitter API. As mentioned, the default is `https://api.twitter.com/oauth/authenticate`, but you also have `https://api.twitter.com/oauth/authorize`. Passing this option as `true` will use the second URL rather than the first. What's the difference? As described [here](https://dev.twitter.com/docs/api/1/get/oauth/authenticate), with `authenticate`, if your user has already granted permission to your application, Twitter will redirect straight back to your application, whereas `authorize` forces the user to go through the "grant permission" screen again. For certain use cases this may be necessary. *Example:* `http://yoursite.com/auth/twitter?use_authorize=true`

## Watch the RailsCast

Ryan Bates has put together an excellent RailsCast on OmniAuth:

[![RailsCast #241](https://www.evernote.com/shard/s35/sh/479f2503-aefa-4542-a7b4-8f84fd22eafc/0571f5a3795a0be3d0b0814312a8d5b7/res/49b5478a-657c-4aff-ae58-dae08b9a46d5/Screen_Shot_2012-07-15_at_12.41.15_PM-20120715-125424.jpg "RailsCast #241 - Simple OmniAuth (revised)")](http://railscasts.com/episodes/241-simple-omniauth-revised)

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
