# Facebook Share

This gem will add an easy-to-use Facebook Share button feature to your Rails project. This gem does not take care of authentication or authorization. It's only purpose is to bind Facebook Share button to anything you want.

Any public method will return just JavaScript code and nothing else.

## How to install

    gem install facebook_share

This gem supports jQuery and Dojo, be sure to have it installed in your project.

In case of jQuery, the gem does not depend on jquery-rails, because some projects use jQuery without it or expose jQuery function to another global variable or use [jQuery.noConflict](http://api.jquery.com/jQuery.noConflict).

Further information about choosing framework are described in next section.

## Code changes

If you don't have a Facebook Application for your project yet, [create one](http://www.facebook.com/developers/createapp.php).

Then add this to your ApplicationHelper

    module ApplicationHelper
      include FacebookShare
      
    end

Global configuration (config/initializers/facebook_share.rb ): 

    FacebookShare.default_facebook_share_options = {
      :framework => :jquery,
      :jquery_function => "$",

      :app_id => "YOUR_APP_ID",
      :status => "false",
      :cookie => "false",
      :xfbml => "false",

      :selector => '.fb_share',
      :locale => "en_US"
    }

You can ommit *app_id* parameter, if you already have a Facebook Application initialized in your project.

Be sure you have
    <div id="fb-root"></div>
in your application layout before you load the Facebook Connect JS

Default facebook Share options can be changed with the above code snippet. The options can be also passed to any public method, so you don't have to rely on defaults at any given time.

* *framework* - choose a JavaScript framework to work with. For now just **:dojo** and **:jquery** are supported.
* *jquery_function* - If you are using jQuery and mapped the jQuery function to a different variable, you can use that to pass a correct jQuery variable name, for example **$j**, **jQuery**, etc.
* *app_id* - your Facebook application ID that will connect your site to Facebook - as described at [FB.init JS SDK](http://developers.facebook.com/docs/reference/javascript/fb.init/)
* *status*, *cookie* and *xfbml* - as described at [FB.init JS SDK](http://developers.facebook.com/docs/reference/javascript/fb.init/)
* *locale* - Facebook locale code representations, ie. en_US, de_DE, pl_PL, etc. The full list of Facebook supported languages is available in http://www.facebook.com/translations/FacebookLocales.xml or at [Facebook Developer Wiki](http://fbdevwiki.com/wiki/Locales). If your locale has both parts of the string the same, for example "de_DE", "pl_PL", since version 0.0.4 you can put just "de" or "pl", etc. The script **does not** check for validity of given locale.
* *selector* - a selector to target Facebook share binding, ".fb_share" by default
* any other parameter will be passed to Facebook's **[FB.ui](http://developers.facebook.com/docs/reference/javascript/fb.ui/)** function, so you can use whichever parameters you need, except for *method*, which defaults always to *publish.stream*

*app_id*, *status*, *cookie*, *xfbml*, *locale*, *selector*, and the various FB.ui parameters also have \_js variants which insert Javascript to calculate the value at runtime.  These Javascript snippets must be expressions, not full statements.  If a \_js option is present, the non-\_js version of the option is ignored.

## Usage

The simplest usage (given you specified your project's Facebook Application ID) is as follows:

    <%= link_to 'Share on Facebook', '#', :class => "fb_share"  %>
    <%= facebook_share_once %>

That will produce a link "Share on Facebook" with a class of "fb_share" and a corresponding JavaScript script tags initializing Facebook app and sharing method bind to click on that link. By default gem passes ".fb_share" selector to the Javascript framework of your choice.

You can find more usage examples at [Railslove blogpost](http://railslove.com/weblog/2011/02/22/introducing-simple-facebook-share-gem/) about this gem.

## Changelog

v0.0.6

* [[Brent Royal-Gordon](https://github.com/brentdax)] - Added \_js keys

v0.0.5

* Added support for [Dojo framework](http://dojotoolkit.org/)

v0.0.4

* Locale guessing, if necessary

v0.0.3

* Added basic tests

v0.0.2

* Added global settings
* Replaced *url* param with *link* to be consistent with Facebook API

v0.0.1

* First public release

## Note on patches/pull requests

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
