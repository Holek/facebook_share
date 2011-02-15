# Facebook Share

This gem will add an easy-to-use Facebook Share button feature to your Rails project. This gem does not take care of authentication or authorization. It's only purpose is to bind Facebook Share button to anything you want.

Any public method will return just JavaScript code and nothing else.

## How To Install

This gem relies on jQuery, be sure to have it installed in your project. It does not depend on jquery-rails gem, because some projects use jQuery without it.

    gem install facebook_share

## Code changes

If you don't have a Facebook Application for your project yet, [create one](http://www.facebook.com/developers/createapp.php).

Then add this to your ApplicationHelper

    module ApplicationHelper
      include FacebookShare

      FacebookShare.default_facebook_share_options = {
        :app_id => "YOUR_APP_ID",
        :status => false,
        :cookie => false,
        :xfbml => false,

        :selector => '.fb_share',
        :locale => "en_US"
      }
    end

You can ommit *app_id* parameter, if you already have a Facebook Application initialized in your project.

Be sure you have <div id="fb-root"></div> in your application layout before you load the Facebook Connect JS

Default facebook Share options can be changed with the above code snippet
* *appid* - your Facebook application ID that will connect your site to Facebook.
* *status*. *cookie* and *xfbml* - as described at [FB.init JS SDK](http://developers.facebook.com/docs/reference/javascript/fb.init/)

* *locale* - Facebook locale code representations, ie. en_US, de_DE, pl_PL, etc. The full list of Facebook supported languages is available in http://www.facebook.com/translations/FacebookLocales.xml or at [Facebook Developer Wiki](http://fbdevwiki.com/wiki/Locales)


## Usage


## Note on Patches/Pull Requests

* Fork the project.
* Create a feature branch
* Make your feature addition or bug fix.
* Add tests.
* Commit, do not mess with Rakefile, version, or history.
* Send me a pull request.

## Copyright

Copyright (c) 2011 Mike Połtyn. Originally build as part of work at [Railslove](http://railslove.com).

## License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
